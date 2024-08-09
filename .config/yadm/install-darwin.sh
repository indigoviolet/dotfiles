#!/usr/bin/env bash
# mac startup


# [[file:../../dev/dotfiles/install.org::*mac startup][mac startup:1]]
set -x
set -euo pipefail
command -v brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install yadm just transcrypt
# mac startup:1 ends here
