# Setup fzf (modern fzf generates shell config directly)
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
fi
