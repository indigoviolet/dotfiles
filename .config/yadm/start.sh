#!/usr/bin/env bash
# [[file:../../README.org::*Get started][Get started:2]]
set_init
yes '' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install yadm

# Note that this won't work on a single line: env var replacement happens before the command runs
# You can do
# $>    GITHUB_PAT=foo && (yadm clone ...)
GITHUB_PAT='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'
yadm clone "https://oauth2:$GITHUB_PAT@github.com/indigoviolet/dotfiles.git" --no-bootstrap

read -p 'Set yadm local.class (<personal|fin|gcp>): ' yadmclass
yadm config local.class $yadmclass && yadm alt && yadm bootstrap
# Get started:2 ends here
