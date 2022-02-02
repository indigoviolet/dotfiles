#!/bin/bash
# Prezto


# [[file:../../../README.org::*Prezto][Prezto:1]]
set -ux
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"
git clone --recurse-submodules https://github.com/belak/prezto-contrib "${HOME}/.zprezto/contrib"
cd ~/.zprezto/contrib && git pull

## poetry completion (https://python-poetry.org/docs/master/#enable-tab-completion-for-bash-fish-or-zsh)
poetry completions zsh > ~/.zprezto/modules/completion/external/src/_poetry
# Prezto:1 ends here
