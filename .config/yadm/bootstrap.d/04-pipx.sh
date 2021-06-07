#/bin/bash
# Pipx

# We use .pipx.json which is created by

# =pipx list --json > ~/.pipx.json=


# [[file:../../../README.org::*Pipx][Pipx:1]]
set -ux
for p in $(cat ~/.pipx.json | jq -r '.venvs[].metadata.main_package.package_or_url'); do
	pipx install $p
done
# Pipx:1 ends here
