#!/usr/bin/env bash
# Mamba (conda)


# [[file:../../../README.org::*Mamba (conda)][Mamba (conda):1]]
set -ux
wget -O Mambaforge.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
bash Mambaforge.sh -b
# Mamba (conda):1 ends here
