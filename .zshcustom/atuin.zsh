# fzf searching shows dupes, and skim is slower, and fzy doesn't have options
eval "$(atuin init zsh --disable-up-arrow)" # --disable-ctrl-r

# zle -N _atuinr_widget _atuinr

# _atuinr() {
#     # https://github.com/ellie/atuin/issues/68
#     output=$(atuin history list --cmd-only | fzf --tac) && BUFFER=$output && CURSOR=${#BUFFER}
# }
# bindkey '^r' _atuinr_widget
