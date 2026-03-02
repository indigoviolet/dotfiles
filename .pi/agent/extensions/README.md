# Pi Extensions

Custom extensions for [pi](https://github.com/badlogic/pi-mono).

## pin.ts

Pin an assistant response and keep it visible as a widget above the editor.

**Commands:**
- `/pin` — select from recent assistant responses to pin (replaces current pin)
- `/unpin` — remove the pinned response

**Shortcut:**
- `Ctrl+Shift+Y` — toggle view: full ↔ minimal (first line only)

Full view renders markdown (tables, code blocks, headings, etc.). State persists across turns and session restore.
