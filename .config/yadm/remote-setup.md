# Remote Dev Machine Setup

Reference for provisioning a new remote dev machine (e.g. Hetzner).

## 1. SSH key via 1Password

Ensure your SSH key is available through the 1Password SSH agent. The key should
appear in `ssh-add -l` via the 1Password agent socket configured in
`~/.ssh/config`:

```
Host *
  IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
```

## 2. Tailscale

On the remote machine (as root):

```bash
curl -fsSL https://tailscale.com/install.sh | sh
tailscale up --ssh --hostname=<readable-name>
```

You can now SSH via the tailscale hostname: `ssh root@<readable-name>`

## 3. Create user

As root on the remote machine:

```bash
# Create user with home directory and bash shell, add to sudo group
useradd -m -s /bin/bash venky && usermod -aG sudo venky

# Set up SSH authorized_keys
mkdir -p /home/venky/.ssh
cp /root/.ssh/authorized_keys /home/venky/.ssh/authorized_keys
chmod 700 /home/venky/.ssh
chmod 600 /home/venky/.ssh/authorized_keys
chown -R venky:venky /home/venky/.ssh

# NOPASSWD sudo
echo "venky ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/venky
chmod 440 /etc/sudoers.d/venky

# Verify
id venky && groups venky
su - venky -c "sudo -l"
```

## 4. Ghostty terminfo

From your local machine, install the ghostty terminfo on the remote:

```bash
infocmp -x xterm-ghostty | ssh venky@<machine> -- tic -x -
```

## 5. Bootstrap dotfiles

SSH in as venky, then:

```bash
mkdir -p ~/dev

# Install mise
curl -fsSL https://mise.run | sh
eval "$(~/.local/bin/mise activate bash --shims)"

# Install gh via mise and authenticate
mise use -g github-cli@latest
gh auth login -h github.com -p https -w
gh auth setup-git

# Install yadm and clone dotfiles
sudo apt-get install -y yadm
yadm clone https://github.com/indigoviolet/dotfiles.git --no-bootstrap
yadm config local.class remote
yadm alt

# Install claude code (standalone — no bun dependency)
curl -fsSL https://claude.ai/install.sh | bash

# Run bootstrap
yadm bootstrap
```

## Notes

- The bootstrap script (`~/.config/yadm/bootstrap`) installs mise, gum, and
  other tools, then hands off to claude code with `bootstrap-prompt.md`.
- For the `remote` class, bootstrap-prompt.md installs basics + dev tools,
  sets up prezto/zsh, and handles gh auth if not already done.
- Transcrypt-encrypted files (SSH keys etc.) are `##c.personal` only — on
  remote machines, use SSH agent forwarding instead.
