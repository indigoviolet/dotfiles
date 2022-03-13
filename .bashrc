# https://stackoverflow.com/a/55893600/14044156
#
# This file is usually executed in non-interactive login shells; but we force it
# to execute in bash scripts (ie non-interactive contexts) by setting BASH_ENV
# in the parent zsh environment


set_init () {
    # Color xtrace prompts, useful in bash scripts
    # https://stackoverflow.com/a/58068110/14044156
    #
    # We don't set this everywhere because:
    #
    # direnv's stdlib is bash, and PS4 getting set on bash shell initialization
    # is seen in the direnv diff; which then gets copied back to the parent
    # shell.
    #
    # Test using some direnv directory:
    #
    # #+begin_src shell
    # cd ~/dev/shapeguard
    # direnv show_dump $DIRENV_DIFF
    # #+end_src
    PS4=$'\e[94m+$BASH_SOURCE:${BASH_LINENO[0]}:${FUNCNAME[0]:-NOFUNC}()>\e[0m '
    set -euxo pipefail
}
