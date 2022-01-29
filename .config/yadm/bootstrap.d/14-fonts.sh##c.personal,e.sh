#!/bin/bash
# Fonts

# On Darwin we would do this with brew


# [[file:../../../README.org::*Fonts][Fonts:1]]
set -eux

# Jetbrains Mono patched (https://github.com/ryanoasis/nerd-fonts#option-5-clone-the-repo)
mkdir -p $HOME/dev && cd $HOME/dev && git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
cd $HOME/dev/nerd-fonts && git sparse-checkout add patched-fonts/JetBrainsMono
./install.sh JetBrainsMono
# Fonts:1 ends here
