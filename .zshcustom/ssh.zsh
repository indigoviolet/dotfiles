function manage-ssh-key() {
    # On my fin laptop, I keep my id_rsa ssh key in my keychain so it can be added with -K argument
    # without me every copy/pasting the password

    ssh-add -l | grep '.ssh/id_rsa ' > /dev/null || ssh-add
}

# https://warlord0blog.wordpress.com/2020/01/29/gnome-keyring-and-ssh-agent/
export SSH_AUTH_SOCK=/run/user/$(id -u)/keyring/ssh
