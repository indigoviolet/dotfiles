#!/bin/bash
# Misc utilities


# [[file:../../../README.org::*Misc utilities][Misc utilities:1]]
set -eux
(command -v less &> /dev/null) || sudo apt-get install --yes less
(command -v htop &> /dev/null) || sudo apt-get install --yes htop
(command -v notify-send &> /dev/null) || sudo apt-get install --yes libnotify-bin
# this is installed with apt-get because brew installs a shitload of dependencies
(command -v svn &>/dev/null) || sudo apt-get install --yes subversion
curl https://raw.githubusercontent.com/gitbits/git-info/master/git-info --output ~/.local/bin/git-info && chmod +x ~/.local/bin/git-info
# Misc utilities:1 ends here
