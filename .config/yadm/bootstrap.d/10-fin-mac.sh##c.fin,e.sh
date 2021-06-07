#!/bin/bash
set -eux
## Extracted from https://s3.amazonaws.com/fin-public-read/fin-mac-bootstrap.sh
## bash <(curl -fsSL https://s3.amazonaws.com/fin-public-read/fin-mac-bootstrap.sh)

GLOBAL_PYTHON_VERSION=3.7.10

brew install pyenv pyenv-virtualenv readline xz 
pyenv install "$GLOBAL_PYTHON_VERSION" || true
pyenv global "$GLOBAL_PYTHON_VERSION"
pyenv rehash

eval "$(pyenv init -)"
pip install --upgrade pip
pip install wheel click ansible

###
### Clone the necessary git repos
###
echo "Cloning any core directories that don't exist yet"
CODE_DIR="${HOME}/code"
mkdir -p "$CODE_DIR"
cd "$CODE_DIR"

for repo in "fin-dev" "fin-analytics" "finfrastructure" ; do
  if [ ! -d "$repo" ]; then
    echo "Cloning $repo"
    git clone "git@github.com:finventures/$repo.git"
  fi
done;

###
### ansible and fa dependencies
###
cd "${HOME}/code/fin-dev" && pip install --upgrade -r requirements.txt

# Run ansible script for the first time
cd "${HOME}/code/fin-dev/bootstrap" && bash ./mac-playbook/run.sh

