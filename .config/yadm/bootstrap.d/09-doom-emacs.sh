#/bin/bash
# Doom emacs


# [[file:../../../README.org::*Doom emacs][Doom emacs:1]]
set -eux
git clone https://github.com/hlissner/doom-emacs "${HOME}/.local/doom-emacs"
EMACSDIR=$HOME/.local/doom-emacs/ $HOME/.local/doom-emacs/bin/doom install
# Doom emacs:1 ends here
