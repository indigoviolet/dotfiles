#!/bin/bash
# [[file:../../README.org::*Get started][Get started:2]]
set -eux
yes '' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install yadm
yadm clone git@github.com:indigoviolet/dotfiles.git --no-bootstrap

read -p 'Set yadm local.class (<personal|fin|gcp>): ' yadmclass
yadm config local.class $yadmclass && yadm alt && yadm bootstrap
# Get started:2 ends here
