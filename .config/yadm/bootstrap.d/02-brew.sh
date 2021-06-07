#/bin/bash
# Brew

# =brew bundle dump  --force --describe --global=

# Note that .Brewfile is an alt file


# [[file:../../../README.org::*Brew][Brew:1]]
set -eux

# install items
if [[ -e ~/.Brewfile ]]; then
	brew bundle --global check || brew bundle --global install -v
fi
# Brew:1 ends here
