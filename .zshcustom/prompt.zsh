if [[ ! $TERM == "dumb" ]]; then
    if [ -x "$(command -v starship)" ]; then
        eval "$(starship init zsh)"
    fi
else
    unsetopt zle
    PS1='$ '
fi

# (vterm prompt tracking, requires vterm.zsh) We know that starship init zsh
# sets $PROMPT, we append vterm_prompt_end per the vterm docs
#
# A few things depend on this:
#
# 1. default-directory in vterms changes with cd
# 2. vterm-beginning-of-line goes to *after* the prompt character, and detached.el
#    depends on this to extract the command line
# 3. vterm-previous/next prompt
#
# If we set this in a starship custom module as below, it doesn't work right and
# runs into issues like this:
# https://unix.stackexchange.com/questions/689453/zsh-tab-completion-moves-command-to-the-right-by-several-spaces-after-modifying
#
#
# * starship config (for record)
#
# [custom.vterm_prompt_end]
# # Vterm prompt and directory tracking (
# # this must work with noninteractive zsh -c (can be changed with shell= option, ie cannot be a function)
# command = "vterm_prompt_end"
# description = "VTerm Prompt End and directory tracking"
# when = ''' test $INSIDE_EMACS = "vterm" '''
# format = '$output'
# # disabled = true
#
#
PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'

function set_window_title() {
    print -Pn "\e]2;%m:%2~\a"
}

function set_cursor_norm() {
    tput cnorm
}
precmd_functions+=(set_window_title)

# colors xtrace prompts
# https://unix.stackexchange.com/a/595628
export PS4='%F{blue}%B+%N:%i>%b%f '

# LS_COLORS, must come after PATH has been set to find vivid
if command -v vivid >/dev/null 2>&1; then
    export LS_COLORS=$(vivid generate dracula)
fi
