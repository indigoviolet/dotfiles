---
name: github-issue-plan
description: Manage agent plan documents as comments on GitHub issues. Handles issue discovery, living plan comments, session logs, and ZenHub pipeline moves. Use at the start of every session to establish or resume a plan.
---

# GitHub Issue Plan Management

Every agent session should be anchored to a GitHub issue. The plan lives in a **comment** on that issue — never in the issue body.

Use the helper at:
```bash
PLAN_TOOL=/Users/venky/.pi/agent/skills/github-issue-plan/agent-plan.py
```

The utility manages **GitHub issue manipulation only**: repo detection, issue lookup/creation, plan-comment create/update, and session logs. It returns JSON by default; use `--field <name>` when you want a single value.

## 0. Detect the repository

Determine the current GitHub repo dynamically:
```bash
REPO=$($PLAN_TOOL --field repo detect-repo)
```
Use `$REPO` in all commands below instead of a hardcoded repo name.

## 1. Find or create the tracking issue

### If an issue number was provided
Use it directly.

### If no issue number was provided
1. **Search** for a likely match — issues assigned to the current user that are open:
   ```bash
   $PLAN_TOOL list-issues --repo "$REPO"
   ```
2. **Present** the top candidates and ask the user which one to use.
3. **If none match**, ask the user for:
   - A descriptive title (not the branch name — use a proper issue title like "Fix v3 extraction for CBIZ" or "Add ingestion roundtrip tests")
   - Brief context / goal
   Then create the issue by writing the confirmed body to a temp file and calling:
   ```bash
   $PLAN_TOOL create-issue --repo "$REPO" --title "<title>" --body-file /tmp/issue-body.md
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
$PLAN_TOOL get-plan --repo "$REPO" --issue {NUMBER}
```
This returns JSON with `exists`, `comment_id`, `url`, and `body` when the plan comment exists.

### If found → resume
Parse the plan content and continue from where it left off.

### If not found → create
Write the full plan body to a temp file. It must start with `<!-- agent-plan -->`.

Then create it:
```bash
$PLAN_TOOL ensure-plan --repo "$REPO" --issue {NUMBER} --body-file /tmp/agent-plan-body.md
```

## 4. Update the living plan

As work progresses, update the plan comment **in place** by writing the full updated markdown body to a temp file (again starting with `<!-- agent-plan -->`) and calling:

```bash
$PLAN_TOOL put-plan --repo "$REPO" --issue {NUMBER} --body-file /tmp/agent-plan-body.md
```

The utility will fetch the latest plan comment before patching, or create it if it does not exist yet.

Keep the plan lean and current:
- Check off completed TODOs
- Add new TODOs as they emerge
- Update context with discoveries and decisions
- Remove stale information (it will be preserved in session logs)

## 5. Post session logs

At **session end** or **major milestones** (e.g., a feature is complete, a significant decision was made), write the full log body to a temp file. It must start with `<!-- agent-log -->`.

Then append it as a new comment:
```bash
$PLAN_TOOL append-log --repo "$REPO" --issue {NUMBER} --body-file /tmp/agent-log-body.md
```

Session logs are **never edited** after posting. They form a chronological history.

When moving completed items from the living plan to a session log, ensure nothing is lost — the log is the archive.

## 6. Explicit no-issue fallback

Only use this when the user explicitly says **not** to use a GitHub issue.

Do **not** use the helper for local fallback. Instead, manage the plan doc directly as a normal file:

- Create the plan at `<project root>/agent_plans/<git-branch>_<short-goal>.md`
- Use normal file operations (`read`, `write`, `edit`) to keep it updated
- Use the same plan structure: Goal, TODOs, Context, File Pointers, optional Sketches
- If you want a session log, create a separate timestamped markdown file next to it or append a dated section manually

This fallback should stay lightweight and ad hoc.

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
