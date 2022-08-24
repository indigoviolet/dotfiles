#!/usr/bin/env bash
# git completion


# [[file:../../../README.org::*git completion][git completion:1]]
set -ux
curl -o ${ZSH_CUSTOM_DIR}/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o ${ZSH_CUSTOM_DIR}/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
# git completion:1 ends here
