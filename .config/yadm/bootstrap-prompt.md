# Bootstrap Agent

You are bootstrapping a development machine. The user's dotfiles are already cloned via yadm, and `yadm alt` has been run to link/render files based on the detected class.

## Principles

- **Idempotent**: skip anything already installed/configured. Check with `command -v` before installing.
- **Install preference**: mise → apt (linux) → brew (mac/linux fallback)
- **Python tools**: use `uv tool install` (not pipx)
- **JS/node tools**: use `bun install -g`
- **Proceed step by step**, confirming each group with the user before moving on.
- **Interactive steps** (logins, auth): pause and walk the user through them.

## Step 1: Core CLI tools via mise

Install globally with `mise use -g <tool>@latest`:

- atuin
- bat
- bat-extras
- delta
- difftastic
- direnv
- fd
- fzf
- gh
- jless
- jq
- just
- lsd
- ripgrep
- ripgrep-all
- starship
- vivid
- yq
- zoxide

## Step 2: CLI tools NOT in mise

These need brew (macOS) or apt (Linux). On Linux, install brew first if not present (`https://brew.sh`).

- abduco
- eget
- icdiff
- lesspipe
- micro
- transcrypt
- xsv

## Step 3: Shell setup — prezto

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

## Step 4: Python tools via uv

Install with `uv tool install <package>`:

**All profiles:**
- jinjanator
- jello
- pypyp

**Personal only:**
- black
- ipython
- isort
- jupytext
- llm
- ruff

## Step 5: Interactive — gh auth

If `gh auth status` fails:

```bash
gh auth login
```

Walk the user through the interactive flow.

## Step 6: Interactive — atuin

If `~/.local/share/atuin/key` exists:

```bash
atuin login -u indigoviolet --key $(cat ~/.local/share/atuin/key)
atuin sync
```

Otherwise, ask the user if they want to register or login.

## Step 7: git-info

```bash
mkdir -p ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/gitbits/git-info/master/git-info --output ~/.local/bin/git-info
chmod +x ~/.local/bin/git-info
```

---

## Personal profile only (skip for remote)

### Homebrew + casks

If on macOS, ensure brew is installed, then:

- Run `brew bundle --global` if `~/.Brewfile` exists (yadm alt should have linked it)
- This handles macOS-specific formulas and casks (1password, iterm2, emacs, fonts, etc.)

### Doom Emacs

If `~/.emacs.d` does not exist:

```bash
git clone https://github.com/hlissner/doom-emacs "${HOME}/.emacs.d"
~/.emacs.d/bin/doom install
```

---

## Remote profile only (skip for personal)

### git-credential-manager (Linux)

```bash
cd /tmp
eget -a '.deb' GitCredentialManager/git-credential-manager
sudo dpkg -i /tmp/gcm*.deb
git credential-manager configure
```

### Tailscale (Linux)

If `tailscale` is not already installed:

```bash
curl -fsSL https://tailscale.com/install.sh | sh
```

---

## Notes

- The user's dotfiles are managed by yadm. Don't modify dotfiles directly — they're version controlled.
- `~/.zshcustom/` contains zsh configuration files that are yadm alt-linked templates.
- mise shims are at `~/.local/share/mise/shims/` — the user's zsh config should already add this to PATH.
- The Brewfile is an alt file — different versions exist for personal vs remote profiles.
