#!/usr/bin/env bash
# Mamba (conda)

# https://github.com/conda-forge/miniforge#non-interactive-install


# [[file:../../../README.org::*Mamba (conda)][Mamba (conda):1]]
set -ux
cd /tmp
wget -O Mambaforge.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
bash Mambaforge.sh -b -p $HOME/.local/mambaforge
# Mamba (conda):1 ends here
