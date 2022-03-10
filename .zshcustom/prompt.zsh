eval "$(starship init zsh)"

# Needs vterm.zsh to load before this
precmd_functions+=(vterm_prompt_end)

function set_window_title(){
    print -Pn "\e]2;%m:%2~\a"
}
precmd_functions+=(set_window_title)

# colors xtrace prompts
# https://unix.stackexchange.com/a/595628
export PS4='%F{blue}%B+%N:%i>%b%f '
