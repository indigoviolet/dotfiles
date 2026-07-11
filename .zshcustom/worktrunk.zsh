# Worktrunk shell integration (directory switching + completions).
# Keep this in ~/.zshcustom instead of letting `wt config shell install` edit ~/.zshrc.
if command -v wt >/dev/null 2>&1; then
  eval "$(wt config shell init zsh)"
fi
