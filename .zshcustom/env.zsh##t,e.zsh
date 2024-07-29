# WARNING: Do not edit this file.
# It was generated by processing {{ yadm.source }}

# Make PATH unique https://unix.stackexchange.com/a/62599
typeset -Ug path

export ALTERNATE_EDITOR=""

{% if yadm.class == "personal" %}
# not reusing frame because we can quit a new frame more easily
export EDITOR="emacsclient -c -a ''"
{% endif %}

{% if yadm.class == "remote" %}
export EDITOR="micro" # installed via brew
{% endif %}

{% if yadm.os == "Darwin" %}
# https://stackoverflow.com/a/76427393. It's important to set this up early,
# especially if $TMPDIR is overridden in some directories (since mac uses
# TMPDIR=/var/folders/.... by default)
export EMACS_SOCKET_NAME="/tmp/emacs$(id -u)/server"
export EDITOR="${EDITOR} --socket-name ${EMACS_SOCKET_NAME}"
{% endif %}

export VISUAL=$EDITOR # for zsh edit-command-line
export GIT_EDITOR=$EDITOR
export LESS="-g -i -M -S --use-color -z-4 -R"
export FZF_TMUX=0

export HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
export HISTSIZE=10000000        # per session
export SAVEHIST=10000000        # history file

setopt INC_APPEND_HISTORY
# https://github.com/sorin-ionescu/prezto/tree/master/modules/history
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE


# TODO: see https://github.com/indigoviolet/zsh-history-filter/blob/master/zsh-history-filter.plugin.zsh#L28 -- we should change this to be a regexp, and turn on zsh's PCRE support
# export HISTORY_FILTER_EXCLUDE=("fc", "history")

path[1,0]=$HOME/.local/bin/
path[1,0]=$HOME/.cargo/bin/

# https://github.com/jdxcode/rtx#ide-integration (vscode doesn't load the function from .zshcustom/asdf.zsh)
path[1,0]=$HOME/.local/share/rtx/shims/


# zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080,underline"
export ZSH_AUTOSUGGEST_STRATEGY=(completion history)

export PYFLYBY_PATH=~/.pyflyby:.../.pyflyby

# https://stackoverflow.com/a/55893600/14044156
# Force bash scripts to execute ~/.bashrc

export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export BASH_ENV=$HOME/.bashrc

# Apheleia -> shfmt formats path[1,0] with a space, which breaks it

# Local Variables:
# eval: (apheleia-mode -1)
# End:
