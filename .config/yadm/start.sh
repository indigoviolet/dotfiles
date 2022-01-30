#!/bin/bash
# [[file:../../README.org::*Get started][Get started:2]]
set -eux
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install yadm
yadm clone git@github.com:indigoviolet/dotfiles.git
# Get started:2 ends here
