# key bindings


autoload -U select-word-style
select-word-style bash

# WORDCHARS="${WORDCHARS:s#/#}"
# WORDCHARS="${WORDCHARS:s#.#}"
# WORDCHARS="${WORDCHARS:s#_#}"

setopt EMACS
bindkey -e

bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word

autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search

bindkey "^H" backward-delete-word

# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line

autoload -Uz edit-command-line
zmodload -i zsh/zle
zle -N        edit-command-line
bindkey '\ee' edit-command-line

zle_highlight=(region:standout special:standout suffix:bold isearch:bg=green )

bindkey '^i' complete-word      # required for _expand completer
