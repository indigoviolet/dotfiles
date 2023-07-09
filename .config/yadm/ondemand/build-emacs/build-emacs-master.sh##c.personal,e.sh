#!/bin/zsh
# [[file:build-emacs.org::*build-emacs-master.sh][build-emacs-master.sh:1]]
# build-emacs-master.sh --- fetch, review, merge and build Emacs.

set -ev

BUILD_DIR=~/dev/emacs
# BRANCH='emacs-29'
BRANCH='master'

# PINNED='HEAD'

# https://discourse.doomemacs.org/t/emacs-head-30-0-50-support/3241/8
PINNED='42fba8f36b19536964d6deb6a34f3fd1c02b43dd'

echo "Using pinned commit $PINNED on $BRANCH in $BUILD_DIR (RETURN to continue, ^C to quit)"
read nought

cd $BUILD_DIR
git fetch

# ensure that the pinned sha is available even though shallow
git fetch --depth=1 origin $PINNED
git checkout $BRANCH && git pull --ff && git clean -dfx && make clean
git checkout $PINNED

sudo apt-get install --no-install-recommends -y \
    libjansson4 libjansson-dev \
    libgccjit0 libgccjit-11-dev\
    gcc-11 \
    libwebp-dev \
    libtree-sitter0 libtree-sitter-dev

# .zshcustom/build.zsh
# 7:export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig
PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig CC= ~/.config/yadm/ondemand/build-emacs/configure-emacs.sh

make -j8

echo Build finished, hit RETURN to continue to testing w/ -Q.
read nought
./src/emacs -Q

echo Hit RETURN to test w/ configuration.
read nought
./src/emacs

echo Hit RETURN to install...
read nought
sudo make -j8 install

installed_commit=$(git rev-parse --short HEAD)
echo "Installed: $installed_commit" | ts >> ~/.config/yadm/ondemand/build-emacs/completed-builds.log

systemctl --user disable emacs.service
sudo rm /usr/local/share/applications/{emacsclient,emacs-mail,emacsclient-mail}.desktop

## we will use an updated version of org; prevent mixed install (M-x org-version)
## also requires `make autoloads` in .emacs.d/.local/.../repos/org and `doom build`
## unfortunately this seems to break org-auto-tangle
# emacs_version=$(emacs --version | head -n1 | cut -d ' ' -f 3)
# sudo mv /usr/local/share/emacs/$emacs_version/lisp/org/ /usr/local/share/emacs/$emacs_version/lisp/org.builtin/

echo Rebuilding doom
doom sync
# build-emacs-master.sh:1 ends here
