#!/bin/bash
# Pipx

# pipx is installed with Brew

# We use .pipx.json which is created by

# =pipx list --json > ~/.pipx.json=

# Note that .pipx.json is an alt file


# [[file:../../../README.org::*Pipx][Pipx:1]]
set -ux
if [[ -e ~/.pipx.json ]]; then
	for p in $(cat ~/.pipx.json | jq -r '.venvs[].metadata.main_package.package_or_url'); do
		pipx install $p
	done
fi
# Pipx:1 ends here
