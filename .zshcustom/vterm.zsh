# https://github.com/akermu/emacs-libvterm#shell-side-configuration
function vterm_printf() {
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ]); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
        #print -R -e -n "\e]$1\e\\"
    fi
}

if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
fi

#
# * Prompt tracking
#
# On a remote machine, this is how vterm can set `default-directory`, which
# in turn influences how emacs/tramp behaves: new terminals, find-file etc
# use that as a reference.
#
# In particular, `hostname` on a remote machine might not return the same
# alias used to log into it, and so might not work with `ssh <...>` - for
# ex., on gcp `hostname` will return `<INSTANCE_NAME>`, but `gcloud compute
# config-ssh` will create aliases of the form `<NAME>.<ZONE>.<PROJECT>`
#
# vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"

vterm_prompt_end() {
    vterm_printf "51;A$(pwd)"
}

vterm_cmd() {
    local vterm_elisp
    vterm_elisp=""
    while [ $# -gt 0 ]; do
        vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
        shift
    done
    vterm_printf "51;E$vterm_elisp"
}

find_file() {
    vterm_cmd find-file "$(realpath "${@:-.}")"
}

dired() {
    find_file
}

# https://github.com/akermu/emacs-libvterm#vterm-enable-manipulate-selection-data-by-osc52
vterm_cp() {
    local input="$([[ -p /dev/stdin ]] && cat - || echo "$@")"
    printf "\e]52;c;$(printf '%s' $input | base64)\a"
}
