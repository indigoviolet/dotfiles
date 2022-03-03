#!/bin/zsh
# build-emacs-master.sh


# [[file:build-emacs.org::*build-emacs-master.sh][build-emacs-master.sh:1]]
# build-emacs-master.sh --- fetch, review, merge and build Emacs.

set -ev

cd ~/dev/emacs

## branch enforcing: turned off for native-comp
# git branch | grep '^\* master' >/dev/null || exit 'Not on branch master!'

git fetch

## News/Diff: not useful
# echo News since HEAD:
# git diff HEAD..FETCH_HEAD -- etc/NEWS
# echo
# echo Commits since HEAD:
# git log --graph --oneline HEAD..FETCH_HEAD
# echo 'Continue with build (RETURN to continue, ^C to quit)?'
# read nought

git pull --ff
git clean -dfx

## on nativecomp: Pinned commit for https://discord.com/channels/406534637242810369/406536226166800384/797785171767197716
# PINNED='213b5d73159cafbdd52b9c0fb0479544cca98a77'
PINNED='HEAD'

echo "Using pinned commit $PINNED on $BUILD (RETURN to continue, ^C to quit)"
read nought

git checkout $PINNED

sudo apt-get install --no-install-recommends -y libjansson4 libjansson-dev libgccjit0 libgccjit-11-dev gcc-11

# .zshcustom/build.zsh
# 7:export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig
CC= ~/.config/yadm/ondemand/build-emacs/configure-emacs.sh

make -j8

echo Build finished, hit RETURN to continue to testing w/ -Q.
read nought
./src/emacs -Q

# doom build/sync needed?

echo Hit RETURN to test w/ configuration.
read nought
./src/emacs

echo Hit RETURN to install...
read nought
sudo make -j8 install

systemctl --user disable emacs.service
sudo rm /usr/local/share/applications/{emacsclient,emacs-mail,emacsclient-mail}.desktop
# build-emacs-master.sh:1 ends here
