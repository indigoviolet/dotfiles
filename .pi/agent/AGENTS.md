# Plan document

- Every session should work from a markdown plan document capturing TODOs and context.
- If the session was started with a plan document, use that. 
- If no plan document was provided, work with the user to define a plan and create a new plan document in `<project root dir>/agent_plans`. The plan doc will be named `<git-branch>_<short-goal>.md`
- Keep the plan doc updated as you learn things.

Plan doc should include:
1. High-level goal
2. TODOs (completed and future). Break down each TODO into granular sub-tasks; check off completed items.
3. Pointers to relevant files
4. Context / summaries of relevant code and data flows
5. Sketches of classes/functions/file organization for future work (optional)

# TASK WORKFLOW (Investigate → Plan → Approve → Implement)

You must STRICTLY adhere to the following sequence of steps for each task you tackle -- each TODO or chunk of work.

**Principle:** You may investigate immediately. You must not modify existing git-tracked files (or otherwise change the implementation) until the user approves an implementation plan.

1. Start new item.
   You must say: "🏁 Starting work on <...> (I will not make code changes until you approve the implementation plan)".

2. Investigate (no approval needed; do not modify existing tracked files).

   Allowed during investigation:
   - Read/search files (`read`, `rg`, `find`, `ls`) and reason about behavior.
   - Run commands/tools that do not modify existing tracked files.
   - Create scratch/throwaway scripts or files anywhere for investigation.
   - Edit the plan doc.

   Constraints during investigation:
   - Do NOT edit existing tracked files.
   - Do NOT stage or commit scratch/throwaway files.
   - If you discover adjacent issues, record them as TODOs and ask before pivoting.

3. Propose an implementation plan (with validation).
   - Write a concrete plan: steps, files to change, expected behavior, and validation commands/tests.
   - Update the plan document with this plan.

4. Get confirmation before implementing.
   You must say: "🕵 Investigation COMPLETE. Plan document has been updated. Ready for your review before implementing. <... plan summary ...>".

   When feedback is provided, go back to Step 2/3 as appropriate.
   ⛔ **WAIT** - Do not proceed without explicit user approval.

5. Implement item (make code changes).
   After this step, you must say "✅ Status of implementation: <... complete, or highlight what is not working ...>".

6. Update the plan document.
   Check off completed TODOs, add new TODOs and/or learnings as appropriate.

7. Ask the user if a commit should be made.
   ⛔ **WAIT** - Do not proceed without user confirmation.

8. Select next item (confirm with user), and go to Step 1.
   Give the user context for where we are in the project and what are the upcoming tasks.
   ⛔ **WAIT** - Do not proceed without user confirmation.


Acknowledge that you have read these instructions by saying "Pinstructions loaded!"


# Tips

- While running bash commands, tee the full output to a temp file before `tail` or `head` so that you can go back to the full output if needed.
- You are allowed to use emoji sparingly and where requested explicitly.
- It's sometimes good to search previous sessions in `~/.pi/agent/sessions/<current working dir>` to find relevant information more quickly
- Don't unnecessarily redact or filter out "PII" or secrets unless I specifically ask you to. If you're concerned, ask me before doing any filtering, and then respect my choice.

# Tools
- `rg` instead of `grep`
- `fd` instead of `find`


