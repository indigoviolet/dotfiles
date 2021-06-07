# -*- mode: Shell-script -*-
#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
#
## Profiling: uncomment zprof at end of file
# zmodload zsh/zprof

if [[ "$TERM" == "dumb" || "$TERM" == "tramp" ]]; then
	unsetopt zle
	unsetopt prompt_cr
	unsetopt prompt_subst
	if whence -w precmd >/dev/null; then
		unfunction precmd
	fi
	if whence -w preexec >/dev/null; then
		unfunction preexec
	fi
	PS1='$ '
	return
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# http://tanguy.ortolo.eu/blog/article25/shrc Non-interactive sessions
# already source ~/.zprofile, but we repeat because some terminals
# eg. vscode don't seem to

ZSH_CUSTOM_DIR=${HOME}/.zshcustom
source ${ZSH_CUSTOM_DIR}/env.zsh
source ${ZSH_CUSTOM_DIR}/brew.zsh

# source ${ZSH_CUSTOM_DIR}/aliases.zsh
source ${ZSH_CUSTOM_DIR}/input.zsh
source ${ZSH_CUSTOM_DIR}/git.zsh
source ${ZSH_CUSTOM_DIR}/ssh.zsh
source ${ZSH_CUSTOM_DIR}/fzf.zsh

#source ${ZSH_CUSTOM_DIR}/pyenv.zsh
source ${ZSH_CUSTOM_DIR}/poetry.zsh

# source ${ZSH_CUSTOM_DIR}/rbenv.zsh
# source ${ZSH_CUSTOM_DIR}/nodenv.zsh

source ${ZSH_CUSTOM_DIR}/yarn.zsh
source ${ZSH_CUSTOM_DIR}/doom.zsh
source ${ZSH_CUSTOM_DIR}/gcloud.zsh
source ${ZSH_CUSTOM_DIR}/gcloud-completion.zsh

source ${ZSH_CUSTOM_DIR}/android.zsh
source ${ZSH_CUSTOM_DIR}/misc.zsh
source ${ZSH_CUSTOM_DIR}/broot.zsh

source ${ZSH_CUSTOM_DIR}/vterm.zsh
source ${ZSH_CUSTOM_DIR}/direnv.zsh

# prepends to path, so keep it last
source ${ZSH_CUSTOM_DIR}/conda.zsh

source ${ZSH_CUSTOM_DIR}/secrets.zsh
source ${ZSH_CUSTOM_DIR}/prompt.zsh

# Tilix https://gnunn1.github.io/tilix-web/manual/vteconfig/
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

source ${ZSH_CUSTOM_DIR}/zinit.zsh

# manage-ssh-key

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# /usr/local/opt/fzf/install after brew install fzf
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Profiling: load at beginning of file
# zprof
