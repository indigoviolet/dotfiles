eval "$(direnv hook zsh)"
direnv-toggle() {
    if [ -z "${DIRENV_DISABLE:-}" ]; then
        unset -f _direnv_hook
        export DIRENV_DISABLE=1
    else
        unset DIRENV_DISABLE
        eval "$(direnv hook zsh)"
    fi
}
