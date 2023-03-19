export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"

zle -N _atuinr_widget _atuinr

_atuinr() {
    # https://github.com/ellie/atuin/issues/68
    output=$(atuin history list --cmd-only | fzf --tac) && BUFFER=$output && CURSOR=${#BUFFER}
}
bindkey '^r' _atuinr_widget
