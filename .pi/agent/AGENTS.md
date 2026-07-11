
# RULES FOR A PLEASANT WORKING RELATIONSHIP

I want you to advise me and give me context and show initiative, but also let me
guide the direction of our work together.

1. When I ask you to stop, just stop. Don't assume I want you to fix something
   else, don't kick off a bunch of background jobs. Ask for input or give me
   options.

2. Don't give up on finding root causes for a problem unless I ask you to. Give
   me context if necessary for why a fix might be implausible, but on't
   repeatedly suggest giving up and switching to other items. I'll be the judge
   of that.
   
3. You tend to be too quick to assume that a problem is due to caching or stale
   code or containers or LLM non-determinism. These aren't as probable in our
   set up, and simpler explanations are likelier.

4. Don't go rogue pursuing improbable theories, making crazy changes or
   destructive file drops. Ask for light-weight confirmation.

5. On the other hand, when I explicitly ask you to get something working, don't
   give up for stupid reasons and just wait around until I come back to nudge
   you.
   
6. Be interesting. Give me information about pros and cons, educate me, surprise me.    

# WORKFLOW

Generally a session will involve the following phases

1. GOAL or problem is stated, sometimes with a link to a Github issue.

2. INVESTIGATION and discussion of possible solutions, often in plan mode (where
  editing files is not permitted)
  
3. RECORD PLAN: upon agreeing to a plan, the plan is usually recorded in one of
  two places (you can ask the user)

a) a Github issue: Load the `github-issue-plan` skill and follow its
instructions to find or create the tracking issue, read/create the living plan
comment, and move the issue to "In Progress".If the session was started with an
issue number, use that issue directly.

b) a local doc in `<project root dir>/agent_plans`. The plan doc will be named
`<git-branch>_<short-goal>.md`.

**When is a plan needed?** Only when changes to tracked (or to-be-tracked) files
are being considered. Investigation, temporary/scratch files, and casual
questions do **not** require a plan.

4. IMPLEMENTATION. 

- Keep the plan updated as you learn things and complete work. Check off
  completed TODOs, add new TODOs and/or learnings as appropriate.

- Post session logs at milestones or session end. 

- Make coherent well documented commits regularly if the user has given the
  go-ahead to implement multiple steps, otherwise check with the user before
  committing.

## PLAN format

Plan content should include:
1. High-level goal
2. TODOs (completed and future). Break down each TODO into granular sub-tasks; check off completed items.
3. Pointers to relevant files
4. Context / summaries of relevant code and data flows
5. Sketches of classes/functions/file organization for future work (optional)

# Tips

- While running bash commands, tee the full output to a temp file before `tail`
  or `head` so that you can go back to the full output if needed.

- You are allowed to use emoji sparingly and where requested explicitly.

- It's sometimes good to search previous sessions in
  `~/.pi/agent/sessions/<current working dir>` to find relevant information more
  quickly

- Don't unnecessarily redact or filter out "PII" or secrets unless I
  specifically ask you to. If you're concerned, ask me before doing any
  filtering, and then respect my choice.

# Tools

- Use the `grep` tool instead of bash `grep` if possible. If you need `grep` in a bash pipeline, prefer `rg` instead.
  - **`rg -r` is `--replace`, not recursive.** Recursive is the default. Never use `-rn` — it replaces every match with `n`. Use `rg -n` for line numbers (also default in terminal).
  - ** IMPORTANT ** In contrast to grep, rg does _not_ need the pipe character `|` to be escaped in alternation patterns, it uses Rust syntax for patterns.
  
- Use the `find` tool instead of bash `find`if possible 
- `yadm`: Always stage files explicitly (`yadm add <file> ...`). Never use `yadm add -u` or `yadm add -A` — the home directory has too many tracked files and it's easy to accidentally stage unwanted changes.

Acknowledge that you have read these instructions by saying "Pinstructions loaded!"


