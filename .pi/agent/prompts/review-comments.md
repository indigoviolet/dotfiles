---
description: Fetch and address unresolved PR review comments
---
Get the PR number using `gh pr view --json number --jq '.number'` if you don't have it already.

Fetch all review comments for this PR using

```
gh api graphql -f query='
            query {
              repository(owner: "additiveai", name: "plus") {
                pullRequest(number: <PR>) {
                  reviewThreads(first: 100) {
                    nodes {
                      isResolved
                      isOutdated
                      comments(first: 10) {
                        nodes {
                          author {
                            login
                          }
                          body
                          path
                          line
                          createdAt
                        }
                      }
                    }
                  }
                }
              }
            }
            ' | jq '.data.repository.pullRequest.reviewThreads.nodes[] | select(.isResolved == false and .isOutdated == false) | {isResolved: .isResolved, isOutdated: .isOutdated, comment: .comments.nodes[0]}')
```
and reviews using

```
gh api graphql -f query='
      query {
        repository(owner: "additiveai", name: "plus") {
          pullRequest(number: <PR>) {
            reviews(first: 100) {
              nodes {
                author {
                  login
                }
                body
                state
                createdAt
              }
            }
          }
        }
      }
      ' | jq '.data.repository.pullRequest.reviews.nodes[] | select(.state != "DISMISSED" and .body != "") | {type: "review", author: .author.login, body: .body, state: .state, createdAt: .createdAt}'
```

**NOTE** The above commands are already valid and execute successfully in Bash. If you are seeing escaping errors, that is because of how you are running them. Put them in a shell script if you have to.

Make a TODO list containing all unaddressed comments. Sort by newest first. Make sure to track each comment's author as well.

For each comment sequentially:

1. Evaluate whether the comment is a valid suggestion or bug. Pay close attention and critically evaluate, especially when the comment author is cursor[bot] or bugbot, which are AI review bots.

2. Explain your recommendation to the author, and work with the author to iterate on the plan or implement it.

**DO NOT** start addressing the comments without confirming with the author.
