#/bin/bash
# Asdf


# [[file:../../../README.org::*Asdf][Asdf:1]]
set -ux
for plugin in nodejs python yarn poetry; do
	asdf plugin add $plugin
done

asdf install python 3.9.0
asdf install python 3.8.1

bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdf install nodejs 13.8.0

asdf install yarn 1.22.10
asdf install poetry 1.1.6
# Asdf:1 ends here
