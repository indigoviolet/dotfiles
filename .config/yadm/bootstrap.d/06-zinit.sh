#!/bin/bash
# Zinit


# [[file:../../../README.org::*Zinit][Zinit:1]]
set -eux
{ mkdir ~/.zinit && git clone https://github.com/zdharma/zinit.git ~/.zinit/bin; } || exit 0
# Zinit:1 ends here
