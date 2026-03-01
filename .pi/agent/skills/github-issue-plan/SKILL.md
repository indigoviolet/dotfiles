---
name: github-issue-plan
description: Manage agent plan documents as comments on GitHub issues. Handles issue discovery, living plan comments, session logs, and ZenHub pipeline moves. Use at the start of every session to establish or resume a plan.
---

# GitHub Issue Plan Management

Every agent session should be anchored to a GitHub issue. The plan lives in a **comment** on that issue — never in the issue body.

## 0. Detect the repository

Determine the current GitHub repo dynamically:
```bash
REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)
```
Use `$REPO` in all `gh` commands below instead of a hardcoded repo name.

## 1. Find or create the tracking issue

### If an issue number was provided
Use it directly.

### If no issue number was provided
1. **Search** for a likely match — issues assigned to the current user that are open:
   ```bash
   gh issue list --repo "$REPO" --assignee @me --state open --json number,title,url --limit 15
   ```
2. **Present** the top candidates and ask the user which one to use.
3. **If none match**, ask the user for:
   - A descriptive title (not the branch name — use a proper issue title like "Fix v3 extraction for CBIZ" or "Add ingestion roundtrip tests")
   - Brief context / goal
   Then create the issue:
   ```bash
   gh issue create --repo "$REPO" --title "<title>" --assignee @me --body "<context from user>"
   ```

## 2. Move to "In Progress" via ZenHub (implementation start only)

Move an issue to the "In Progress" pipeline **only when implementation begins** (i.e., after investigation + plan review and explicit user approval to implement).

During investigation/planning, keep the issue in `/my-todos` (or its current pre-implementation pipeline state).

Refer to `docs/agent-guides/zenhub-mcp.md` for the full workflow:
1. Get pipeline IDs with `getWorkspacePipelinesAndRepositories`
2. Find the issue with `searchLatestIssues` (use the issue number or title)
3. Move it with `moveIssueToPipeline` using the issue's GraphQL ID and the "In Progress" pipeline ID

If the ZenHub MCP is unavailable, note it and continue — don't block on this.

## 3. Read or create the living plan comment

The living plan is a single comment on the issue, identified by an HTML marker on the **first line**.

### Find it
```bash
gh api repos/$REPO/issues/{NUMBER}/comments \
  --jq '.[] | select(.body | startswith("<!-- agent-plan -->")) | {id, body}'
```

### If found → resume
Parse the plan content and continue from where it left off.

### If not found → create
```bash
gh api repos/$REPO/issues/{NUMBER}/comments \
  -f body='<!-- agent-plan -->
## 🤖 Agent Plan

### Goal
<goal from user or issue body>

### TODOs
- [ ] <first task>

### Context
<relevant files, decisions, data flows>

### File Pointers
- `path/to/relevant/file.py`
'
```

## 4. Update the living plan

As work progresses, update the plan comment **in place**:

```bash
gh api /repos/$REPO/issues/comments/{COMMENT_ID} -X PATCH \
  -f body='<!-- agent-plan -->
## 🤖 Agent Plan
<updated content>'
```

**Important:** The body must be passed as a single `-f body=` argument. For multi-line content, write to a temp file and use `jq` to construct the JSON payload:

```bash
cat /tmp/agent-plan-body.md | jq -Rs '{body: .}' | \
  gh api /repos/$REPO/issues/comments/{COMMENT_ID} -X PATCH --input -
```

Keep the plan lean and current:
- Check off completed TODOs
- Add new TODOs as they emerge
- Update context with discoveries and decisions
- Remove stale information (it will be preserved in session logs)

## 5. Post session logs

At **session end** or **major milestones** (e.g., a feature is complete, a significant decision was made), post an append-only session log comment:

```bash
gh api repos/$REPO/issues/{NUMBER}/comments \
  -f body='<!-- agent-log -->
## 📝 Session Log — <YYYY-MM-DD>

### Completed
- <what was done, with commit SHAs or PR links>

### Decisions
- <key decisions and rationale>

### Learnings
- <anything discovered that is worth preserving>
'
```

Session logs are **never edited** after posting. They form a chronological history.

When moving completed items from the living plan to a session log, ensure nothing is lost — the log is the archive.

## Safety rules

- **Never modify the issue body.** The body is human-owned. Only manage comments with `<!-- agent-plan -->` and `<!-- agent-log -->` markers.
- **Never delete comments** you didn't create (i.e., comments without the agent markers).
- **Always fetch the latest plan comment** before updating — don't use stale state from earlier in the session.
- **Do not move issues to "In Progress" during investigation/planning.** Move only when implementation begins and the user has approved implementation.
- When creating an issue, **always confirm the title and context** with the user before creating.

## Plan content guidelines

The living plan comment should include:

1. **Goal** — high-level objective for the current work
2. **TODOs** — granular, checkable tasks. Break down each TODO into sub-tasks as needed.
3. **Context** — summaries of relevant code, data flows, decisions
4. **File Pointers** — paths to key files being worked on
5. **Sketches** (optional) — class/function/file organization for upcoming work
