#!/usr/bin/env bash
# Asdf

# asdf installed with Brew

# [[file:../../../README.org::*Asdf][Asdf:1]]
set -ux

## https://github.com/asdf-vm/asdf/issues/276#issuecomment-907063520
cut -d' ' -f1 .tool-versions | xargs -i asdf plugin add {}

## installs from .tool-versions (which is an alt file)
## the install-poetry installer is default with 1.2, but that is still alpha and has bugs <2022-02-07 Mon>
# ASDF_POETRY_INSTALL_URL=https://install.python-poetry.org asdf install
# Asdf:1 ends here
