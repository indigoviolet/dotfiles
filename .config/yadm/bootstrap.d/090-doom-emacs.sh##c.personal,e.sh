#!/usr/bin/env bash
# Doom emacs


# [[file:../../../README.org::*Doom emacs][Doom emacs:1]]
set_init
{ git clone https://github.com/hlissner/doom-emacs "${HOME}/.emacs.d" && $HOME/.emacs.d/bin/doom install; } || exit 0
# Doom emacs:1 ends here
