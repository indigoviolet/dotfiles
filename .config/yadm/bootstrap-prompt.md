# Bootstrap Agent

You are bootstrapping a development machine. The user's dotfiles are already cloned via yadm, and `yadm alt` has been run to link/render files based on the detected class.

## Principles

- **Idempotent**: skip anything already installed/configured. To check if a mise tool is installed, use `mise ls -g` (not `command -v`, which can match shell aliases or stale shims).
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
- github-cli (provides `gh` — do NOT use the mise tool name `gh`, its aqua backend has attestation verification failures)
- jq
- lsd
- ripgrep
- starship
- vivid
- zoxide

**Install tools one at a time** (or in small groups) with `mise use -g`. Batch installs can partially fail — if one tool errors, the others may not get written to config.toml.

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

### Work tools

Only for personal profile on macOS. Additive — ask the user if they want work tools installed.

If yes, run `brew bundle --file ~/.Brewfile.work`. This includes:
- Cloud/infra: coder, terraform, pulumi, helm, cloud-sql-proxy, caddy, rclone, lakefs
- PDF tools: diff-pdf, ghostscript, mupdf, poppler, qpdf
- Data: excel-compare, gsheet, xlsxsql
- Docker: hadolint, devcontainer
- All VSCode extensions

### Personal extras

Only for personal profile. Skip entirely for remote.

**Homebrew + casks:** if on macOS, ensure brew is installed, then run `brew bundle --global` if `~/.Brewfile` exists (yadm alt should have linked it). This handles macOS-specific formulas and casks (1password, emacs, fonts, etc.)

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

If `gh auth status` fails, run `gh auth login -h github.com -p https -w` (web-based flow works well on headless/remote machines) and walk the user through it.
Then run `gh auth setup-git` to configure git credential helper.

### Interactive — atuin

**Personal only.** Skip for remote.

If `~/.local/share/atuin/key` exists, ask the user for their atuin password, then:

```bash
atuin login -u indigoviolet -p <PASSWORD> -k "$(cat ~/.local/share/atuin/key)"
atuin sync
```

The `-p` flag is **required** — `atuin login` panics without a TTY if password is not provided on the command line.

Otherwise, ask the user if they want to register or login.

---

## Notes

- The user's dotfiles are managed by yadm. Don't modify dotfiles directly — they're version controlled.
- `~/.zshcustom/` contains zsh configuration files that are yadm alt-linked templates.
- mise shims are at `~/.local/share/mise/shims/` — the user's zsh config should already add this to PATH.
- The Brewfile is an alt file — different versions exist for personal vs remote profiles.
