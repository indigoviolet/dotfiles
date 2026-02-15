# Bootstrap Agent

You are bootstrapping a development machine. The user's dotfiles are already cloned via yadm, and `yadm alt` has been run to link/render files based on the detected class.

## Principles

- **Idempotent**: skip anything already installed/configured. Check with `command -v` before installing.
- **Install preference**: mise → apt (linux) → brew (mac/linux fallback)
- **Python tools**: use `uv tool install` (not pipx)
- **JS/node tools**: use `bun install -g`
- **Interactive steps** (logins, auth): pause and walk the user through them.
- mise replaces direnv and just — do not install those separately.

## Tool groups

**Ask the user which groups to install.** Present the list and let them pick. Always install "basics". The rest are optional.

### Basics

Core CLI tools via mise (`mise use -g <tool>@latest`):

- atuin
- fd
- gh
- jq
- lsd
- ripgrep
- starship
- vivid
- zoxide

Core CLI tools NOT in mise (brew or apt):

- lesspipe
- transcrypt

### Dev tools

Additional CLI tools for active development, via mise:

- delta
- difftastic
- fzf
- jless
- yq

Via brew/apt:

- icdiff
- xsv

### Python tools

Install with `uv tool install <package>`:

(none currently — this group exists for future additions)

### Personal extras

Only for personal profile. Skip entirely for remote.

**Homebrew + casks:** if on macOS, ensure brew is installed, then run `brew bundle --global` if `~/.Brewfile` exists (yadm alt should have linked it). This handles macOS-specific formulas and casks (1password, iterm2, emacs, fonts, etc.)

**Doom Emacs:** if `~/.emacs.d` does not exist:

```bash
git clone https://github.com/hlissner/doom-emacs "${HOME}/.emacs.d"
~/.emacs.d/bin/doom install
```

### Remote extras

Only for remote profile. Skip entirely for personal.

**Tailscale (Linux):** if not already installed:

```bash
curl -fsSL https://tailscale.com/install.sh | sh
```

---

## After tool groups: Shell & interactive setup

### Shell setup — prezto

If `~/.zprezto` does not exist:

```bash
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"
git clone --recurse-submodules https://github.com/belak/prezto-contrib "${HOME}/.zprezto/contrib"
```

On Linux, if zsh is not the login shell:

```bash
sudo apt-get install --no-install-recommends -y zsh
sudo chsh -s $(which zsh) $(whoami)
```

### Interactive — gh auth

If `gh auth status` fails, run `gh auth login` and walk the user through it.
Then run `gh auth setup-git` to configure git credential helper.

### Interactive — atuin

If `~/.local/share/atuin/key` exists:

```bash
atuin login -u indigoviolet --key $(cat ~/.local/share/atuin/key)
atuin sync
```

Otherwise, ask the user if they want to register or login.

### git-info

```bash
mkdir -p ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/gitbits/git-info/master/git-info --output ~/.local/bin/git-info
chmod +x ~/.local/bin/git-info
```

---

## Notes

- The user's dotfiles are managed by yadm. Don't modify dotfiles directly — they're version controlled.
- `~/.zshcustom/` contains zsh configuration files that are yadm alt-linked templates.
- mise shims are at `~/.local/share/mise/shims/` — the user's zsh config should already add this to PATH.
- The Brewfile is an alt file — different versions exist for personal vs remote profiles.
