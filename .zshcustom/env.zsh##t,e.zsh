# WARNING: Do not edit this file.
# It was generated by processing {{ yadm.source }}

# this file is sourced in .zprofile, so it runs in non-interactive sessions
# http://tanguy.ortolo.eu/blog/article25/shrc

# Make PATH unique https://unix.stackexchange.com/a/62599
typeset -Ug path

export ALTERNATE_EDITOR=""

{% if yadm.class == "personal" %}
export EDITOR="emacsclient"
{% endif %}

{% if yadm.class == "gcp" %}
export EDITOR="micro"           # installed via brew
{% endif %}

{% if yadm.os == "Darwin" %}
export EDITOR="code --wait"
{% endif %}

export VISUAL=$EDITOR # for zsh edit-command-line
export GIT_EDITOR=$EDITOR

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

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080,underline"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

{% if yadm.distro == "Ubuntu" %}

# For libpng (pdf-tools), emacs build etc.
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig

# For python-build, esp. on 20.04, where python-build wants libffi.so.8, but
# "apt libffi-dev" only provides libffi.so.7 (see
# https://dev.to/ajkerrigan/homebrew-pyenv-ctypes-oh-my-3d9)
export CC="$(brew --prefix gcc)/bin/gcc-11"
{% endif %}
