---
description: Manage my personal TODO list (GitHub issue tracker)
---

You are managing my personal TODO list stored as GitHub issue #9251 in `additiveai/plus`.

## Data layout

- **Issue body** has three sections: `## 🔥 Active`, `## 👀 Tracking`, `## 📋 Backlog`.
- **Done items** live in comment ID `3970436925` on the same issue (marked with `<!-- todos-done -->`). Most operations never touch this.
- **Local cache**: `~/.pi/agent/skills/my-todos/.cache.md` (body content) and `.cache_updated_at` (timestamp).

## Cache protocol

### Reads (summary, show items) — use cache directly
1. If `.cache.md` exists, read it. Done.
2. If it doesn't exist, fetch from GitHub, create the cache files:
   ```bash
   gh issue view 9251 --repo additiveai/plus --json body --jq '.body' > ~/.pi/agent/skills/my-todos/.cache.md
   gh issue view 9251 --repo additiveai/plus --json updatedAt --jq '.updatedAt' > ~/.pi/agent/skills/my-todos/.cache_updated_at
   ```

### Writes (add, done, activate, backlog, track, remove) — check freshness first
1. Fetch the current `updated_at` from GitHub:
   ```bash
   gh issue view 9251 --repo additiveai/plus --json updatedAt --jq '.updatedAt'
   ```
2. Compare with `.cache_updated_at`. If they differ → refetch the body into `.cache.md` and update `.cache_updated_at`.
3. Edit `.cache.md` (the local file) to make the changes.
4. Push the updated cache to GitHub:
   ```bash
   gh issue edit 9251 --repo additiveai/plus --body-file ~/.pi/agent/skills/my-todos/.cache.md
   ```
5. Fetch the new `updated_at` from GitHub and write it to `.cache_updated_at`.

### Force refresh
If the user says "refresh" or "sync", fetch from GitHub unconditionally and rebuild the cache.

---

## Sections

- **Active**, **Tracking**, and **Backlog** contain markdown task lists (`- [ ] item` or `- [x] item`), draggable in the GitHub UI.
- **Tracking** items are things being monitored but not actively worked on. May include links to Teams threads, Notion pages, or GitHub issues.
- Sections may contain `_No items yet._` as a placeholder — remove that when adding items.

## Done comment

Most operations never need this. Only fetch it for "done" operations or explicit "show done" requests.

### Reading Done
```bash
gh api /repos/additiveai/plus/issues/comments/3970436925 --jq '.body'
```

### Updating Done
Write updated content to a temp file (must start with `<!-- todos-done -->`), then:
```bash
cat /tmp/todos-done-body.md | jq -Rs '{body: .}' | \
  gh api /repos/additiveai/plus/issues/comments/3970436925 -X PATCH --input -
```

---

## Operations

### No arguments or "summary" → Show status
- Read from cache (no API call needed).
- Show counts per section.
- List all Active items, then Tracking items, then Backlog items.
- **Number every item with a single continuous sequence across all sections** (Active starts at 1, Tracking continues from where Active left off, Backlog continues from Tracking). This lets the user refer to any item by number in follow-up commands (e.g., "done 3", "backlog 5, 7", "activate 22").
- For Done, just say: "Done items are tracked in a [separate comment](https://github.com/additiveai/plus/issues/9251#issuecomment-3970436925)."
- Link to the issue: https://github.com/additiveai/plus/issues/9251

### Referring to items by number
When the user references items by number (e.g., "done 3", "backlog 5, 7"), match against the numbering from the most recent summary displayed in this conversation. If no summary was shown yet, show one first so numbers are established.

### "add ..." → Add items
- Parse the items from my message. I may give a comma-separated list, bullet points, or natural language.
- Add each as `- [ ] <item>` to the **Active** section by default.
- If I say "add to backlog", put them in Backlog instead.
- Follow the write protocol (check freshness → edit cache → push).

### "done ..." → Complete items
- Find the matching item(s) in Active, Tracking, or Backlog (fuzzy match on the description).
- Follow the write protocol for the issue body (remove items from their section).
- **Also fetch the Done comment**, append the completed items as `- [x] <item>`, and PATCH it.

### "backlog ..." → Deprioritize items
- Move matching Active items to Backlog.
- Follow the write protocol.

### "track ..." → Add tracking items
- Add items as `- [ ] <item>` to the **Tracking** section.
- Follow the write protocol.

### "activate ..." or "pick up ..." → Prioritize items
- Move matching Backlog or Tracking items to Active.
- Follow the write protocol.

### "remove ..." or "drop ..." → Delete items
- Remove matching items entirely (from any section). Confirm before removing.
- Follow the write protocol.
- If removing a Done item, fetch and update the Done comment too.

### Free-form → Discuss
- If my message doesn't match the above patterns, treat it as a conversation about my todos. Offer suggestions, help prioritize, etc.

## Enrichment
When adding items, try to find related GitHub issues, PRs, or branches using `gh issue list --search`, `gh pr list --search`, etc. in `additiveai/plus`. If you find a likely match, **propose the enrichment and confirm with the user before adding the link**. Format links inline: `- [ ] Description — [PR #123](url)` or `- [ ] Description — [#456](url)`.

Use `gh auth status` to discover the GitHub username for author-scoped searches (e.g., `gh pr list --author <username>`).

## Rules
- Preserve the three-section structure and any existing items you're not modifying.
- After any mutation, show me what changed (e.g., "Added 2 items to Active").
- Keep items concise but faithful to what I said.
- **Never touch the Done comment unless the operation requires it** (only "done" and explicit "show done" requests).

My request: $ARGUMENTS
