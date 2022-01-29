#!/bin/bash
# Asdf

# asdf installed with Brew


# [[file:../../../README.org::*Asdf][Asdf:1]]
set -ux

## https://github.com/asdf-vm/asdf/issues/276#issuecomment-907063520
cut -d' ' -f1 .tool-versions | xargs -i asdf plugin add  {}

## installs from .tool-versions (which is an alt file)
asdf install
# Asdf:1 ends here
