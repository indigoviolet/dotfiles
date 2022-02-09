#!/bin/sh
# configure-emacs.sh


# [[file:build-emacs.org::*configure-emacs.sh][configure-emacs.sh:1]]
set -ev

V=${1-head}
TK=${TK-yes}
PREFIX=/usr/local

if [ ! -f configure ]; then
    ./autogen.sh all
fi

echo version: $V

# Keep an eye on:
#   . --with-cairo
case $V in
nativecomp)
    ./configure \
        --prefix=$PREFIX \
        --with-x-toolkit=$TK \
        --with-modules \
        --with-xwidgets \
        --with-file-notification=yes \
        --with-gameuser=no \
        --with-cairo \
        --with-mailutils \
        --with-native-compilation
    ;;
head)
    ./configure \
        --prefix=$PREFIX \
        --with-x-toolkit=$TK \
        --with-modules \
        --with-xwidgets \
        --with-file-notification=yes \
        --with-gameuser=no \
        --with-cairo \
        --with-mailutils
    ;;
nothreads)
    ./configure \
        --prefix=$PREFIX \
        --with-x-toolkit=$TK \
        --with-modules \
        --with-file-notification=yes \
        --with-gameuser=no \
        --with-mailutils \
        --without-threads
    ;;
pdmp)
    ./configure \
        --prefix=$PREFIX \
        --with-x-toolkit=$TK \
        --with-modules \
        --with-file-notification=yes \
        --with-gameuser=no \
        --with-mailutils \
        --with-pdumper=yes \
        --with-unexec=yes \
        --with-dumping=pdumper
    ;;
26)
    ./configure \
        --prefix=$PREFIX \
        --with-x-toolkit=$TK \
        --with-modules \
        --with-file-notification=yes \
        --with-mailutils
    ;;
25)
    ./configure \
        --prefix=$PREFIX \
        --with-x-toolkit=$TK \
        --with-modules \
        --with-file-notification=yes
    ;;
*)
    echo "I don't know how to configure Emacs version $1"
    exit 1
    ;;
esac
# configure-emacs.sh:1 ends here
