#!/usr/bin/env bash
set -euo pipefail

# Bootstrap a new machine: install mise, then yadm, then clone dotfiles.
# Usage: curl -fsSL <raw-github-url> | bash

command -v mise || curl -fsSL https://mise.run | sh
eval "$(~/.local/bin/mise activate bash --shims)" 2>/dev/null || eval "$(mise activate bash --shims)"

mise use -g yadm@latest

echo "Now run: yadm clone <your-dotfiles-repo-url>"
