#!/usr/bin/env zsh
set -eux

# https://scriptingosx.com/2019/11/associative-arrays-in-zsh/
declare -A utils
utils=(
    # these come with ubuntu
    [less]=less
    [notify-send]=libnotify-bin
    # brew installs shitloads of dependencies
    [svn]=subversion

{% if yadm.class == "personal" %}
{% endif %}

{% if yadm.class == "gcp" %}
    # not present in brew/Debian
    # [nvtop]=nvtop
    [netstat]=net-tools
{% endif %}
)
for util lib in ${(kv)utils}; do
    (command -v $util &> /dev/null) || sudo apt-get install --no-install-recommends -y $lib
done

## git-info


## poetry completion in prezto (https://python-poetry.org/docs/master/#enable-tab-completion-for-bash-fish-or-zsh)
## poetry installed with asdf
# poetry completions zsh > ~/.zprezto/modules/completion/external/src/_poetry


## GCM core git credential helper (see https://blog.djnavarro.net/posts/2021-08-08_git-credential-helpers/)
# this is interactive
# gh install GitCredentialManager/git-credential-manager

TEMPDIR=$(mktemp -d)
gh release download -p '*.deb' -R GitCredentialManager/git-credential-manager --clobber -D $TEMPDIR && sudo dpkg -i $TEMPDIR/gcm*.deb
git credential-manager configure

# Tailscale
curl -fsSL https://pkgs.tailscale.com/unstable/ubuntu/jammy.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/unstable/ubuntu/jammy.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt-get update
sudo apt-get install -y tailscale
