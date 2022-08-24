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
poetry completions zsh > ~/.zprezto/modules/completion/external/src/_poetry

## GCM core git credential helper (see https://blog.djnavarro.net/posts/2021-08-08_git-credential-helpers/)
gcm_latest_release=$(
    curl -s https://api.github.com/repos/GitCredentialManager/git-credential-manager/releases/latest |
        jq -cr '.assets[] | select(.name | contains("deb")) | .browser_download_url')
gcm_deb=$(curl -sw '%{filename_effective}' -LO $gcm_latest_release --output-dir /tmp)
sudo dpkg -i $gcm_deb && rm $gcm_deb -f
# Misc utilities:1 ends here
