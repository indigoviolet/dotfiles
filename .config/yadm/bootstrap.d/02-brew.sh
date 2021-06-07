#/bin/bash
# Brew

# =brew bundle dump --global --force --describe=


# [[file:../../../README.org::*Brew][Brew:1]]
set -eux

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# install items
brew bundle --global check || brew bundle --global install -v
# Brew:1 ends here
