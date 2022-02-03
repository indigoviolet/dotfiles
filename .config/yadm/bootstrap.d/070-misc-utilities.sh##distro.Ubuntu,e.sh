#!/bin/bash
# Misc utilities


# [[file:../../../README.org::*Misc utilities][Misc utilities:1]]
set -eux
(command -v less &> /dev/null) || sudo apt-get install --no-install-recommends -y less
(command -v htop &> /dev/null) || sudo apt-get install --no-install-recommends -y htop
(command -v notify-send &> /dev/null) || sudo apt-get install --no-install-recommends -y libnotify-bin
# this is installed with apt-get because brew installs a shitload of dependencies
(command -v svn &>/dev/null) || sudo apt-get install --no-install-recommends -y subversion

## git-info
mkdir -p ~/.local/bin && curl -fsSL https://raw.githubusercontent.com/gitbits/git-info/master/git-info --output ~/.local/bin/git-info && chmod +x ~/.local/bin/git-info

## poetry completion in prezto (https://python-poetry.org/docs/master/#enable-tab-completion-for-bash-fish-or-zsh)
## poetry installed with asdf
poetry completions zsh > ~/.zprezto/modules/completion/external/src/_poetry

## GCM core git credential helper (see https://blog.djnavarro.net/posts/2021-08-08_git-credential-helpers/)
gcm_latest_release=$(curl -s https://api.github.com/repos/GitCredentialManager/git-credential-manager/releases/latest | jq -cr '.assets[] | select(.content_type | contains("deb")) | .browser_download_url')
gcm_deb=$(curl -sw '%{filename_effective}' -LO $gcm_latest_release --output-dir /tmp)
sudo dpkg -i $gcm_deb && rm $gcm_deb -f
# Misc utilities:1 ends here
