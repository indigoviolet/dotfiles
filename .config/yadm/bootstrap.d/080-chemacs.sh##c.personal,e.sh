#!/usr/bin/env bash
# chemacs


# [[file:../../../README.org::*chemacs][chemacs:1]]
set -eux
{ git clone https://github.com/plexus/chemacs.git "${HOME}/.local/chemacs" && $HOME/.local/chemacs/install.sh; } || exit 0
# chemacs:1 ends here
