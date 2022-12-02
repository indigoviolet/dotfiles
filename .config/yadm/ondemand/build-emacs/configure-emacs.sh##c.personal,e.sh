#!/bin/sh
# configure-emacs.sh


# [[file:build-emacs.org::*configure-emacs.sh][configure-emacs.sh:1]]
set -ev

PREFIX=/usr/local

if [ ! -f configure ]; then
    ./autogen.sh all
fi

echo version: $V

# --with-xwidgets needed for katex-render (which requires --with-x-toolkit=gtk3)
# --with-pgtk only for Wayland\
./configure \
    --prefix=$PREFIX \
    --with-native-compilation \
    --with-json \
    --with-tree-sitter \
    --with-xwidgets \
    --with-modules \
    --program-transform-name=s/^ctags$/ctags_emacs/ \
    --with-file-notification=yes \
    --with-x-toolkit=gtk3 \
    --without-compress-install\
    --with-gameuser=no \
    --with-cairo \
    CFLAGS="-O2 -pipe -march=native -fomit-frame-pointer"
# configure-emacs.sh:1 ends here
