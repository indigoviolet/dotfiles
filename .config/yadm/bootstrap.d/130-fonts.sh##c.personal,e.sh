#!/bin/bash
# Fonts

# On Darwin we would do this with brew


# [[file:../../../README.org::*Fonts][Fonts:1]]
set -euxo pipefail

# Jetbrains Mono patched (https://github.com/ryanoasis/nerd-fonts#option-5-clone-the-repo)
if [[ ! -d  $HOME/dev/nerd-fonts ]]; then
    mkdir -p $HOME/dev
    cd $HOME/dev
    git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
else
    cd $HOME/dev/nerd-fonts
    git fetch
fi

for font in JetBrainsMono/Ligatures IBMPlexMono VictorMono Iosevka; do
    git sparse-checkout add patched-fonts/$font
    ./install.sh "${font%%/*}"
done

# Should we do this via doomscript? https://github.com/doomemacs/doomemacs/issues/6494
echo 'y' | emacs -l ~/.config/doom/init.el --batch -f all-the-icons-install-fonts
# Fonts:1 ends here
