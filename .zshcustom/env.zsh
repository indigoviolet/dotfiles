# this file is sourced in .zprofile, so it runs in non-interactive sessions
# http://tanguy.ortolo.eu/blog/article25/shrc

# Make PATH unique https://unix.stackexchange.com/a/62599
typeset -Ug path

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient"
export VISUAL=$EDITOR # for zsh edit-command-line
export GIT_EDITOR="emacsclient"

export FZF_TMUX=0
export SAVEHIST=10000000

setopt INC_APPEND_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY

path[1,0]=$HOME/.dotfiles/bin/
path[1,0]=$HOME/.local/bin/
path[1,0]=$HOME/.cargo/bin/

# For libpng (pdf-tools), emacs build etc.
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig
