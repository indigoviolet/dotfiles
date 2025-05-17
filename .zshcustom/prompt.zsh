
tmux_prompt() {
    # eg https://github.com/tmux/tmux/issues/3734
    printf "\e]133;A\e\\"
}

if [[ $TERM == "dumb" ]]; then
    unsetopt zle
    PS1='> '
else
    if [ -x "$(command -v starship)" ]; then
        eval "$(starship init zsh)"
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
    if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
        setopt PROMPT_SUBST
        # PROMPT=$PROMPT'%{$(vterm_prompt_end)%}%{$(tmux_prompt)%}'
        PROMPT=$PROMPT'%{$(vterm_prompt_end)%}%'
        # PROMPT=$PROMPT'%{$(tmux_prompt)%}'
    fi

    function set_window_title() {
        # uname -n instead of %m, because %m is the hostname, which is sometimes changed
        print -Pn "\e]2;%~:$(uname -n | cut -c1-5)\a"
    }

    function set_cursor_norm() {
        tput cnorm
    }

    precmd_functions+=(set_window_title set_cursor_norm)

    # see zpreztorc:plugin olets/zsh-window-title for a different way to set the window title so vterm can pick it up
    # https://github.com/olets/zsh-window-title#cli
    precmd_functions+=(set_cursor_norm)

    # colors xtrace prompts
    # https://unix.stackexchange.com/a/595628
    # see set_x instead in .bashrc
    # export PS4='%F{blue}%B+%N:%i>%b%f '

    # LS_COLORS, must come after PATH has been set to find vivid
    if command -v vivid >/dev/null 2>&1; then
        export LS_COLORS=$(vivid generate gruvbox-dark-soft)

        # https://github.com/ohmyzsh/ohmyzsh/issues/6060#issuecomment-1454972502
        zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    fi

    # [ -n "$EAT_SHELL_INTEGRATION_DIR" ] && source "$EAT_SHELL_INTEGRATION_DIR/zsh"
fi
