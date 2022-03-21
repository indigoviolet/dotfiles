eval "$(starship init zsh)"

#
# * Prompt tracking
#
# Needs vterm.zsh to load before this
#
# https://github.com/rothgar/mastering-zsh/blob/master/docs/config/hooks.md
#
# - precmd :: fires before prompt is drawn
# - preexec :: fires before command is executed
#
# In our context, preexec appears to work better at finding previous prompts than precmd  
#
add-zsh-hook preexec vterm_prompt_end

function set_window_title(){
    print -Pn "\e]2;%m:%2~\a"
}
precmd_functions+=(set_window_title)

# colors xtrace prompts
# https://unix.stackexchange.com/a/595628
export PS4='%F{blue}%B+%N:%i>%b%f '
