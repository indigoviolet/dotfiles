---
description: Resolve git merge/rebase conflicts in the current branch
---
# Resolve Merge Conflicts

Your job is to resolve merge conflicts in the current branch of the current repo.

If this command is being invoked, there are unresolved merge conflicts you need to fix.

To see the commits on this branch relative to the merge base:

  `git log $(git merge-base main <branch-name>)..<branch-name>`

Or, you can inspect the rebase state:

  `cat "$(git rev-parse --git-dir)/rebase-merge/done" "$(git rev-parse --git-dir)/rebase-merge/git-rebase-todo" 2>/dev/null | grep -v "^#" | grep -v "^$"`

Find all merge conflicts using `rg` to find conflict markers:

  `rg "<<<<<<<"`

For each conflict, decide whether to:

1. Keep **our** changes (the current branch)
2. Keep **their** changes (`main`)
3. Use a careful, intelligent combination of both

When you are confident about how to resolve a conflict:

0. Give me a summary of what you decided to do and why.
1. Edit the file to the desired final state
2. Remove all conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
3. Save the file and run any relevant checks or tests if practical
4. Stage the resolved files with `git add`
5. Use `GIT_EDITOR=true git rebase --continue` to continue the rebase after each conflict resolution.

## Very Important: Don't be afraid to ask for help

If you are not sure how a conflict should be resolved, stop and ask me for direction or clarification.

1. Show me the conflicting chunks
2. Explain what you believe you should do
3. Wait for confirmation

Now go resolve the conflicts.
