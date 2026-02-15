# https://stackoverflow.com/a/55893600/14044156
#
# This file is usually executed in non-interactive login shells; but we force it
# to execute in bash scripts (ie non-interactive contexts) by setting BASH_ENV
# in the parent zsh environment

set_init() {
    set_x
    set -euo pipefail
}

set_x() {
    # Color xtrace prompts, useful in bash scripts
    # https://stackoverflow.com/a/58068110/14044156
    #
    # We don't set this everywhere because:
    #
    # direnv's stdlib is bash, and PS4 getting set on bash shell initialization
    # is seen in the direnv diff; which then gets copied back to the parent
    # shell.
    #
    # Test using some direnv directory:
    #
    # #+begin_src shell
    # cd ~/dev/shapeguard
    # direnv show_dump $DIRENV_DIFF
    # #+end_src
    PS4=$'\e[94m+$BASH_SOURCE:${BASH_LINENO[0]}:${FUNCNAME[0]:-}()>\e[0m '
    set -x
}

PATH_add() {
    local dir=$1

    if [[ -z "$dir" ]]; then
        return 1
    fi

    case ":$PATH:" in
        *":$dir:"*) ;;
        *) PATH="$dir:$PATH" ;;
    esac
}

export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

PATH_add "$HOME/.local/bin"
PATH_add "$HOME/.cargo/bin"
PATH_add "$HOME/.local/share/mise/shims"
PATH_add "$HOME/.bun/bin"
PATH_add "/.sprite/bin"

HOMEBREW_PREFIX="/opt/homebrew"

if [[ -x "$HOMEBREW_PREFIX/bin/brew" ]]; then
    eval "$("$HOMEBREW_PREFIX/bin/brew" shellenv)"
elif [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate bash)"
fi

if [[ -f "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi
