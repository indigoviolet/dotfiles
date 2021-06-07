#/bin/bash
# build deps

# for pyenv builds https://github.com/pyenv/pyenv/wiki/common-build-problems (which also affect asdf)


# [[file:../../../README.org::*build deps][build deps:1]]
set -eux
sudo apt-get update
sudo apt-get install --yes clang
sudo apt-get install --no-install-recommends -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
# build deps:1 ends here
