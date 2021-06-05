eval "$(starship init zsh)"

# Needs vterm.zsh to load before this
precmd_functions+=(vterm_prompt_end)
