# https://github.com/direnv/direnv/issues/73
#
#
export_function() {
    local name=$1
    local shell_type=${2:-bash}  # Default to bash if no second argument is provided
    local alias_dir=$PWD/.direnv/aliases
    local target="$alias_dir/$name"

    mkdir -p "$alias_dir"

    # Update PATH if needed
    if ! [[ ":$PATH:" == *":$alias_dir:"* ]]; then
        PATH_add "$alias_dir"
    fi

    # Start the target file with the appropriate shebang
    if [ "$shell_type" = "zsh" ]; then
        echo "#!/usr/bin/env zsh" > "$target"
    else
        echo "#!/usr/bin/env bash" > "$target"
    fi

    # Conditionally write either function or alias
    if declare -f "$name" >/dev/null; then
        declare -f "$name" >> "$target" 2>/dev/null
        echo "$name \"\$@\"" >> "$target"
    else
        echo "$@" >> "$target"
    fi

    chmod +x "$target"
}

