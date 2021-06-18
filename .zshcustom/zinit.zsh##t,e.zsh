# WARNING: Do not edit this file.
# It was generated by processing {{ yadm.source }}

ZINIT_DIR="${HOME}/.zinit"

function zinit_setup() {
    source $ZINIT_DIR/bin/zinit.zsh
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit
}


test -e $ZINIT_DIR/bin/zinit.zsh && zinit_setup

# too noisy and interruptive
#zinit load marlonrichert/zsh-autocomplete

{% if yadm.os == 'Linux' %}
zinit load asdf-vm/asdf
{% endif %}

# function _zinit_install_auto_notify() {
#     zinit light MichaelAquilina/zsh-auto-notify
#     export AUTO_NOTIFY_THRESHOLD=20
# }
# command -v notify-send &>/dev/null && _zinit_install_auto_notify


# zinit ice as"completion"; zinit snippet 'https://github.com/esc/conda-zsh-completion/blob/master/_conda'

autoload -Uz compinit
compinit

# zinit light Aloxaf/fzf-tab
# enable-fzf-tab
# zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
# zstyle ':fzf-tab:*' accept-line enter
# zstyle ':fzf-tab:*' print-query alt-enter

zinit cdreplay -q