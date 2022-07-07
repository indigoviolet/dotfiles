# WARNING: Do not edit this file.
# It was generated by processing {{ yadm.source }}

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

path[1,0]=$HOME/.local/bin/
path[1,0]=$HOME/.cargo/bin/

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080,underline"
export ZSH_AUTOSUGGEST_STRATEGY=(completion history)


export PYFLYBY_PATH=~/.pyflyby:.../.pyflyby

# https://stackoverflow.com/a/55893600/14044156
# Force bash scripts to execute ~/.bashrc
export BASH_ENV=$HOME/.bashrc
