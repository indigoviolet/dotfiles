#
# |                 | login_yes                    | login_no     |
# |-----------------+------------------------------+--------------|
# | interactive_yes | zshenv zprofile zshrc zlogin | zshenv zshrc |
# | interactive_no  | zshenv zprofile zlogin       | zshenv       |
#
# http://tanguy.ortolo.eu/blog/article25/shrc
#
# Non-interactive sessions already source ~/.zprofile, but we repeat because some
# terminals eg. vscode don't seem to ((Edit: actually, I think vscode loads
# .zprofile in a parent shell and doesn't source it again in each terminal))
#
# Previously we were preventing double sourcing by having a guard, but this breaks
# when modules (which execute after zprofile, via zshrc->zpreztorc) override
# variables we set in env.zsh. Is there harm in double sourcing?

## Not exported so it doesn't propagate to sub-shells
# [[ $NONINTERACTIVE_ZSH_SOURCED -eq 1 ]] && return || NONINTERACTIVE_ZSH_SOURCED=1

ZSH_CUSTOM_DIR=${HOME}/.zshcustom
source ${ZSH_CUSTOM_DIR}/env.zsh
source ${ZSH_CUSTOM_DIR}/scriptlib.zsh
