# Yadm dotfiles

Personal dotfiles managed by [yadm](https://yadm.io).

## Setup

Run `yadm clone` and then `yadm bootstrap`. The bootstrap script installs
[mise](https://mise.run) and core tools, then hands off to an LLM agent with
[bootstrap-prompt.md](.config/yadm/bootstrap-prompt.md) for interactive setup.

See [`.config/yadm/bootstrap`](.config/yadm/bootstrap) for the entry point.

## Reference

- [`.config/yadm/notes.org`](.config/yadm/notes.org) — yadm classes, transcrypt, alt files, zsh secrets, Kinesis Advantage, Mac setup notes
- [`.config/yadm/remote-setup.md`](.config/yadm/remote-setup.md) — provisioning a new remote dev machine (Hetzner, tailscale, user setup, bootstrap)
- [`linux_laptop.org`](linux_laptop.org) — Linux laptop config (suspend/hibernate, power management, audio, udev rules, etc.)
