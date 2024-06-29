# key bindings
# https://wiki.archlinux.org/title/zsh#Key_bindings

autoload -U select-word-style
select-word-style bash

# WORDCHARS="${WORDCHARS:s#/#}"
# WORDCHARS="${WORDCHARS:s#.#}"
# WORDCHARS="${WORDCHARS:s#_#}"

setopt EMACS
bindkey -e

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
# [[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
# [[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# bindkey "\e[1~" beginning-of-line
# bindkey "\e[4~" end-of-line
# bindkey "\e[5~" beginning-of-history
# bindkey "\e[6~" end-of-history
# bindkey "\e[3~" delete-char
# bindkey "\e[2~" quoted-insert
# bindkey "\e[5C" forward-word
# bindkey "\eOc" emacs-forward-word
# bindkey "\e[5D" backward-word
# bindkey "\eOd" emacs-backward-word
# bindkey "\e\e[C" forward-word
# bindkey "\e\e[D" backward-word

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

bindkey "^H" backward-delete-for

# word non RH/Debian xterm, can't hurt for RH/DEbian xterm
# bindkey "\eOH" beginning-of-line
# bindkey "\eOF" end-of-line

autoload -Uz edit-command-line
zmodload -i zsh/zle
zle -N        edit-command-line
# M-e
bindkey '\ee' edit-command-line

# zle_highlight=(region:standout special:standout suffix:bold isearch:bg=green )
# bindkey '^i' complete-word      # required for _expand completer
# bindkey '^I' complete-word      # complete

# https://github.com/marlonrichert/zsh-autocomplete#make-tab-and-shifttab-change-the-selection-in-the-menu
bindkey              '^I' menu-select
bindkey -M menuselect              '^I'         menu-complete


