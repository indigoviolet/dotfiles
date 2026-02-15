---
description: Find and address all claude:/ai: inline comments in the codebase
---
Find all inline comments starting with `claude:` or `ai:` in the codebase and address them.

Use a pattern like "[[:space:]]*(#|//)\s*(claude|ai):\s*.+".
Skip ipynb files.
Add each such comment to your TODO list.

For each comment found:
1. Read the file and understand the context around the comment
2. Implement the requested change described in the comment
3. Remove the inline comment after addressing it

Example comments to find:
- `# claude: make this a keywords function`
- `# ai: refactor this to use async`
- `// claude: add error handling here`

Report on all addressed inline comments, and how they were resolved.

To end, repeat the search for inline comments. If no remaining inline comments
are found, report that the codebase is now clean.
