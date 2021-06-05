FZF_DIR="$HOMEBREW_PREFIX/opt/fzf"

function setup_fzf() {

    # Setup fzf
    # ---------
    if [[ ! "$PATH" == *$FZF_DIR/bin* ]]; then
      path+=($FZF_DIR/bin)
    fi

    # Man path
    # --------
    if [[ ! "$MANPATH" == *$FZF_DIR/man* && -d "$FZF_DIR/man" ]]; then
      export MANPATH="$MANPATH:$FZF_DIR/man"
    fi

    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "$FZF_DIR/shell/completion.zsh" 2> /dev/null

    # Key bindings
    # ------------
    source "$FZF_DIR/shell/key-bindings.zsh"
    # bindkey '^G' fzf-file-widget
}

command -v fzf &> /dev/null && setup_fzf
