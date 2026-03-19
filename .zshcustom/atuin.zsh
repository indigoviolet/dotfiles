# fzf searching shows dupes, and skim is slower, and fzy doesn't have options
# eval "$(atuin hex init)"

if [[ "$-" == *i* ]] && [[ -t 0 ]] && [[ -t 1 ]]; then
    _atuin_hex_tmux_current="${TMUX:-}"
    _atuin_hex_tmux_previous="${ATUIN_HEX_TMUX:-}"

    if [[ -z "${ATUIN_HEX_ACTIVE:-}" ]] || [[ "$_atuin_hex_tmux_current" != "$_atuin_hex_tmux_previous" ]]; then
        export ATUIN_HEX_ACTIVE=1
        export ATUIN_HEX_TMUX="$_atuin_hex_tmux_current"
        exec atuin hex
    fi

    unset _atuin_hex_tmux_current _atuin_hex_tmux_previous
fi

eval "$(atuin init zsh --disable-up-arrow)" # --disable-ctrl-r

# zle -N _atuinr_widget _atuinr

# _atuinr() {
#     # https://github.com/ellie/atuin/issues/68
#     output=$(atuin history list --cmd-only | fzf --tac) && BUFFER=$output && CURSOR=${#BUFFER}
# }
# bindkey '^r' _atuinr_widget
