#!/bin/bash
# Prezto


# [[file:../../../README.org::*Prezto][Prezto:1]]
set -ux
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"
git clone --recurse-submodules https://github.com/belak/prezto-contrib "${HOME}/.zprezto/contrib"
cd ~/.zprezto/contrib && git pull
# Prezto:1 ends here
