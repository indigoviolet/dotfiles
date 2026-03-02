/**
 * Pin extension — pin an assistant response and toggle its visibility.
 *
 * ── Future version (overlay-based, multi-pin) ──────────────────────────
 *
 * /pin opens an overlay widget showing a list of all pinned responses.
 * Click one to view it scrollable in the overlay. Can go back to list view.
 * Remembers state (selected item, scroll position) on Esc to dismiss —
 * re-opening /pin restores where you left off.
 *
 * Keys inside the overlay:
 *   P         — select a new assistant message to pin (add to list)
 *   u         — unpin the currently highlighted item
 *   U         — unpin all
 *   Enter     — view the highlighted pin's full content (scrollable)
 *   Backspace — back to list view from content view
 *   Esc       — dismiss overlay (state preserved)
 *
 * Needs: overlay with { overlay: true }, SelectList for pin list,
 * scrollable Text view for content, multi-pin state array.
 * Mouse click fold/expand not feasible — pi doesn't enable mouse reporting.
 * ───────────────────────────────────────────────────────────────────────
 *
 * Current (simple) version:
 *
 * Commands:
 *   /pin          — select a recent assistant response to pin (replaces current pin)
 *   /unpin        — remove the pinned response
 *
 * Shortcut:
 *   Ctrl+Shift+Y — toggle view: full ↔ minimal (first line)
 *
 * The pinned content is shown as a widget above the editor. State persists
 * across turns via appendEntry, so it survives compaction and reload.
 */

import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";
import { DynamicBorder, getMarkdownTheme } from "@mariozechner/pi-coding-agent";
import { Container, Key, Markdown, type SelectItem, SelectList, Text, truncateToWidth, wrapTextWithAnsi } from "@mariozechner/pi-tui";

// ── State ──────────────────────────────────────────────────────────────

type PinView = "full" | "minimal";

interface PinState {
	/** The entry id of the pinned assistant message */
	entryId: string;
	/** Plain text content of the pinned message */
	content: string;
	/** Current view mode */
	view: PinView;
}

let pin: PinState | undefined;

// ── Helpers ────────────────────────────────────────────────────────────

/** Extract plain text from an assistant message's content blocks. */
function extractText(content: unknown): string {
	if (typeof content === "string") return content;
	if (!Array.isArray(content)) return "";
	return content
		.filter((b: any) => b?.type === "text" && typeof b.text === "string")
		.map((b: any) => b.text as string)
		.join("\n")
		.trim();
}

/** Return recent assistant messages (newest first) from the current branch. */
function getAssistantMessages(ctx: ExtensionContext): { entryId: string; text: string }[] {
	const branch = ctx.sessionManager.getBranch();
	const results: { entryId: string; text: string }[] = [];
	for (let i = branch.length - 1; i >= 0; i--) {
		const entry = branch[i] as any;
		if (entry.type === "message" && entry.message?.role === "assistant") {
			const text = extractText(entry.message.content);
			if (text) results.push({ entryId: entry.id, text });
		}
		if (results.length >= 20) break;
	}
	return results;
}

// ── Extension ──────────────────────────────────────────────────────────

export default function pinExtension(pi: ExtensionAPI) {

	// ── Widget rendering ───────────────────────────────────────────────

	function updateWidget(ctx: ExtensionContext) {
		if (!ctx.hasUI) return;

		if (!pin) {
			ctx.ui.setWidget("pin", undefined);
			return;
		}

		ctx.ui.setWidget("pin", (_tui, theme) => {
			const content = pin!.content;
			const view = pin!.view;
			const mdTheme = getMarkdownTheme();
			const md = new Markdown(content, 1, 0, mdTheme);
			return {
				render(width: number): string[] {
					const border = theme.fg("accent", "─".repeat(Math.floor(width / 2)));
					const hint = theme.fg("dim", "(ctrl+shift+y · /unpin)");

					if (view === "minimal") {
						const header = theme.fg("accent", "📌 ") + truncateToWidth(content.split("\n")[0], width - 20) + "  " + hint;
						return [truncateToWidth(border, width), truncateToWidth(" " + header, width), truncateToWidth(border, width)];
					}

					// full — render markdown
					const header = theme.fg("accent", "📌 pinned") + "  " + hint;
					const mdLines = md.render(width).map(l => truncateToWidth(l, width));
					return [
						truncateToWidth(border, width),
						truncateToWidth(" " + header, width),
						...mdLines,
						truncateToWidth(border, width),
					];
				},
				invalidate() { md.invalidate(); },
			};
		});
	}

	function updateStatus(ctx: ExtensionContext) {
		if (!ctx.hasUI) return;
		if (pin) {
			ctx.ui.setStatus("pin", ctx.ui.theme.fg("accent", "📌"));
		} else {
			ctx.ui.setStatus("pin", undefined);
		}
	}

	function persist() {
		pi.appendEntry("pin-state", pin ? { entryId: pin.entryId, content: pin.content, view: pin.view } : null);
	}

	function toggleView(): PinView {
		return pin!.view === "full" ? "minimal" : "full";
	}

	// ── Commands ────────────────────────────────────────────────────────

	pi.registerCommand("pin", {
		description: "Pin an assistant response (shows widget above editor)",
		handler: async (_args, ctx) => {
			const msgs = getAssistantMessages(ctx);
			if (msgs.length === 0) {
				ctx.ui.notify("No assistant messages to pin", "warning");
				return;
			}

			const items: SelectItem[] = msgs.map((m, i) => {
				const preview = m.text.split("\n")[0].slice(0, 80);
				return {
					value: String(i),
					label: preview,
					description: `${m.text.length} chars`,
				};
			});

			const result = await ctx.ui.custom<string | null>((tui, theme, _kb, done) => {
				const container = new Container();
				container.addChild(new DynamicBorder((s: string) => theme.fg("accent", s)));
				container.addChild(new Text(theme.fg("accent", theme.bold("Pin a Response")), 1, 0));

				const selectList = new SelectList(items, Math.min(items.length, 12), {
					selectedPrefix: (t) => theme.fg("accent", t),
					selectedText: (t) => theme.fg("accent", t),
					description: (t) => theme.fg("muted", t),
					scrollInfo: (t) => theme.fg("dim", t),
					noMatch: (t) => theme.fg("warning", t),
				});
				selectList.onSelect = (item) => done(item.value);
				selectList.onCancel = () => done(null);
				container.addChild(selectList);

				container.addChild(new Text(theme.fg("dim", "↑↓ navigate · type to filter · enter select · esc cancel"), 1, 0));
				container.addChild(new DynamicBorder((s: string) => theme.fg("accent", s)));

				return {
					render: (w: number) => container.render(w),
					invalidate: () => container.invalidate(),
					handleInput: (data: string) => { selectList.handleInput(data); tui.requestRender(); },
				};
			});

			if (result === null) return;

			const idx = parseInt(result, 10);
			const chosen = msgs[idx];
			if (!chosen) return;

			pin = { entryId: chosen.entryId, content: chosen.text, view: "full" };
			persist();
			updateWidget(ctx);
			updateStatus(ctx);
			ctx.ui.notify("Response pinned", "info");
		},
	});

	pi.registerCommand("unpin", {
		description: "Remove the pinned response",
		handler: async (_args, ctx) => {
			if (!pin) {
				ctx.ui.notify("Nothing is pinned", "warning");
				return;
			}
			pin = undefined;
			persist();
			updateWidget(ctx);
			updateStatus(ctx);
			ctx.ui.notify("Unpinned", "info");
		},
	});

	// ── Shortcut ───────────────────────────────────────────────────────

	pi.registerShortcut(Key.ctrlShift("y"), {
		description: "Toggle pinned response view: full ↔ minimal",
		handler: async (ctx) => {
			if (!pin) {
				ctx.ui.notify("Nothing is pinned. Use /pin first.", "warning");
				return;
			}
			pin.view = toggleView();
			persist();
			updateWidget(ctx);
			updateStatus(ctx);
		},
	});

	// ── Session restore ────────────────────────────────────────────────

	pi.on("session_start", async (_event, ctx) => {
		pin = undefined;

		// Find last pin-state entry
		const entries = ctx.sessionManager.getEntries();
		for (let i = entries.length - 1; i >= 0; i--) {
			const e = entries[i] as any;
			if (e.type === "custom" && e.customType === "pin-state") {
				if (e.data && e.data.content) {
					pin = { entryId: e.data.entryId, content: e.data.content, view: e.data.view ?? "full" };
				}
				break;
			}
		}

		updateWidget(ctx);
		updateStatus(ctx);
	});

	pi.on("session_switch", async (_event, ctx) => {
		// Re-restore on session switch
		pin = undefined;
		const entries = ctx.sessionManager.getEntries();
		for (let i = entries.length - 1; i >= 0; i--) {
			const e = entries[i] as any;
			if (e.type === "custom" && e.customType === "pin-state") {
				if (e.data && e.data.content) {
					pin = { entryId: e.data.entryId, content: e.data.content, view: e.data.view ?? "full" };
				}
				break;
			}
		}
		updateWidget(ctx);
		updateStatus(ctx);
	});
}
