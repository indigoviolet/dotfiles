#!/usr/bin/env zsh
# Misc utilities


# [[file:../../../README.org::*Misc utilities][Misc utilities:1]]
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
mkdir -p ~/.local/bin && curl -fsSL https://raw.githubusercontent.com/gitbits/git-info/master/git-info --output ~/.local/bin/git-info && chmod +x ~/.local/bin/git-info

## poetry completion in prezto (https://python-poetry.org/docs/master/#enable-tab-completion-for-bash-fish-or-zsh)
## poetry installed with asdf
# poetry completions zsh > ~/.zprezto/modules/completion/external/src/_poetry

## Handy way to install things from github
for ext in redraw/gh-install; do
    (gh extension list | grep $ext) && echo "installed" || gh install $ext
done

## GCM core git credential helper (see https://blog.djnavarro.net/posts/2021-08-08_git-credential-helpers/)
# this is interactive
# gh install GitCredentialManager/git-credential-manager

TEMPDIR=$(mktemp -d)
gh release download -p '*.deb' -R GitCredentialManager/git-credential-manager --clobber -D $TEMPDIR && sudo dpkg -i $TEMPDIR/gcm*.deb
git credential-manager configure

# huawei matebook
# https://github.com/qu1x/huawei-wmi/tree/master/debian#repository
echo "deb https://deb.qu1x.org buster main" | sudo tee /etc/apt/sources.list.d/qu1x.list
# sudo apt-key adv --keyserver hkp://pool.sks-keyservers.net --recv-keys 4503d1ab

# matebook-applet
echo "deb [signed-by=/usr/share/keyrings/matebook-applet.key] http://evgenykuznetsov.org/repo/ stable main" | sudo tee /etc/apt/sources.list.d/matebook-applet.list
wget -qO - https://raw.githubusercontent.com/nekr0z/matebook-applet/master/matebook-applet.key | sudo tee /usr/share/keyrings/matebook-applet.key

# twemoji fonts
sudo apt-add-repository -y -S "deb https://ppa.launchpadcontent.net/eosrei/fonts/ubuntu/ impish main"
sudo apt-get update
sudo apt-get install -y fonts-twemoji-svginot


# Tailscale
curl -fsSL https://pkgs.tailscale.com/unstable/ubuntu/jammy.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/unstable/ubuntu/jammy.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt-get update
sudo apt-get install -y tailscale
# Misc utilities:1 ends here
