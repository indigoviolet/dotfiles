#!/bin/bash
# Leechblock



# [[file:../../../README.org::*Leechblock][Leechblock:1]]
set -ux
mkdir -p $HOME/dev && cd $HOME/dev && gh repo clone indigoviolet/LeechBlockNG-chrome
cd LeechBlockNG-chrome && ./install-jquery.sh
# Leechblock:1 ends here
