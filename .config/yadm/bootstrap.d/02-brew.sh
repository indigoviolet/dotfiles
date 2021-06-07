#/bin/bash
# Brew

# =brew bundle dump --global -f=


# [[file:../../../README.org::*Brew][Brew:1]]
set -eux
brew bundle --global check || brew bundle --global install -v
# Brew:1 ends here
