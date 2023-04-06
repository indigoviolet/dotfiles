layout_conda() {

    # Simplified version of layout_anaconda
    # https://github.com/direnv/direnv/blob/b57a363beea1f365a5fe63164e268a0b119f8411/stdlib.sh#L881
    # which won't create environments and uses micromamba
    local env_spec=$1
    local env_name
    local env_loc
    local conda
    local REPLY

    conda=$(command -v micromamba)

    realpath.dirname "$conda"
    PATH_add "$REPLY"

    if [[ "${env_spec%%/*}" == "." ]]; then
        # "./foo" relative prefix
        realpath.absolute "$env_spec"
        env_loc="$REPLY"
    elif [[ ! "$env_spec" == "${env_spec#/}" ]]; then
        # "/foo" absolute prefix
        env_loc="$env_spec"
    elif [[ -n "$env_spec" ]]; then
        # "name" specified
        env_name="$env_spec"
        env_loc=$("$conda" env list | grep -- '^'"$env_name"'\s')
        env_loc="${env_loc##* }"
    else
        log_error "Invalid environment specification: $env_spec"
        exit 1
    fi

    eval "$( "$conda" shell -s zsh activate "$env_loc" )"
}

# Local Variables:
# sh-shell: bash
# End:
