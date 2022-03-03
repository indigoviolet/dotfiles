#!/bin/sh
# configure-emacs.sh


# [[file:build-emacs.org::*configure-emacs.sh][configure-emacs.sh:1]]
set -ev

PREFIX=/usr/local

if [ ! -f configure ]; then
    ./autogen.sh all
fi

echo version: $V

# --with-xwidgets needed for katex-render
./configure \
    --prefix=$PREFIX \
    --with-native-compilation \
    --with-json \
    --with-xwidgets \
    --with-modules \
    --with-file-notification=yes \
    --with-pgtk \
    --with-x-toolkit=gtk3 \
    --with-gameuser=no \
    --with-cairo
# configure-emacs.sh:1 ends here
