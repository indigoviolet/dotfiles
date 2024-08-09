#!/usr/bin/env bash
# linux startup


# [[file:../../dev/dotfiles/install.org::*linux startup][linux startup:1]]
set -x
set -euo pipefail
command -v brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install yadm just transcrypt
# linux startup:1 ends here
