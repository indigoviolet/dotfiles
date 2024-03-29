# WARNING: Do not edit this file.
# It was generated by processing {{ yadm.source }}

{% if yadm.class == "personal_ubuntu" %}
# https://jamezrin.name/my-perfect-ssh-agent-configuration
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

# # On graphical Ubuntu, gnome-keyring-daemon is running but doesn't set the right
# # SSH_AUTH_SOCK variable
# # https://warlord0blog.wordpress.com/2020/01/29/gnome-keyring-and-ssh-agent/
# export SSH_AUTH_SOCK=/run/user/$(id -u)/keyring/ssh

ssh-add -l >/dev/null || ssh-add
{% endif %}

{% if yadm.class == "remote" %}
# No ssh-agent necessary: instead we use ForwardAgent to forward ssh-keys.
#
# This requires that
#
# - ssh-agent be running locally (echo $SSH_AUTH_SOCK)
# - no ssh-agent be running remotely
# - "ssh-add -l" shows keys locally
# - `ForwardAgent yes` in .ssh/config or use "ssh -A"
# - remote machine be in local .ssh/authorized_keys
#
#
{% endif %}

{% if yadm.class == "personal_mac" %}

function start_ssh_agent_reuse() {
    if [ ! -S ~/.ssh/ssh_auth_sock ]; then
        echo "'ssh-agent' has not been started since the last reboot. Starting 'ssh-agent' now."
        eval "$(ssh-agent -s)"
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    fi
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
}

# On OSX, id_rsa ssh key can be in keychain so it can be added with -K argument
start_ssh_agent_reuse
ssh-add -l >/dev/null || ssh-add --apple-use-keychain
{% endif %}
