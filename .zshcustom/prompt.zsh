eval "$(starship init zsh)"

# Needs vterm.zsh to load before this
precmd_functions+=(vterm_prompt_end)

function set_window_title(){
    print -Pn "\e]2;%m:%2~\a"
}
precmd_functions+=(set_window_title)
