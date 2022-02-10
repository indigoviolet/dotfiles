# Prevent double sourcing:
#
# http://tanguy.ortolo.eu/blog/article25/shrc
#
# Non-interactive sessions already source ~/.zprofile, but we repeat because
# some terminals eg. vscode don't seem to
#
# (Edit: actually, I think vscode loads .zprofile in a parent shell and doesn't
# source it again in each terminal)

[[ $NONINTERACTIVE_ZSH_SOURCED -eq 1 ]] && return || export NONINTERACTIVE_ZSH_SOURCED=1

ZSH_CUSTOM_DIR=${HOME}/.zshcustom
source ${ZSH_CUSTOM_DIR}/env.zsh
source ${ZSH_CUSTOM_DIR}/scriptlib.zsh
