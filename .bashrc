# https://stackoverflow.com/a/55893600/14044156
#
# This file is usually executed in non-interactive login shells; but we force it
# to execute in bash scripts (ie non-interactive contexts) by setting BASH_ENV
# in the parent zsh environment


# Color xtrace prompts, useful in bash scripts
# https://stackoverflow.com/a/58068110/14044156
export PS4=$'\e[94m+$BASH_SOURCE:${BASH_LINENO[0]}:${FUNCNAME[0]:-NOFUNC}()>\e[0m '
