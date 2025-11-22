# Nix-Darwin macOS Configuration

A declarative macOS system configuration managed with [nix-darwin](https://github.com/nix-darwin/nix-darwin), [Home Manager](https://github.com/nix-community/home-manager), and [Nix Flakes](https://wiki.nixos.org/wiki/Flakes). This repository contains a complete setup for macOS including system packages, GUI applications, development tools, shell configuration, and system preferences.

## Table of Contents

- [What is nix-darwin?](#what-is-nix-darwin)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration Overview](#configuration-overview)
- [What's Included](#whats-included)
- [Usage](#usage)
- [Customization](#customization)
- [Project Structure](#project-structure)
- [Troubleshooting](#troubleshooting)
- [Maintenance](#maintenance)

## What is nix-darwin?

[nix-darwin](https://github.com/nix-darwin/nix-darwin) is a tool that lets you manage your macOS system configuration declaratively using Nix. You can version control your entire system setup, making it reproducible and easy to replicate across machines. This means:

- **Reproducible**: Rebuild the exact same environment on any Mac
- **Version Controlled**: Track all changes in git
- **Declarative**: Define what you want, not how to get it
- **Atomic**: Updates are atomic - either everything works or nothing changes

## Features

- 🎨 **System Configuration**: Dock, Finder, Trackpad, Keyboard, and macOS preferences
- 📦 **Package Management**: System packages via Nix and GUI apps via Homebrew
- 🛠️ **Development Tools**: Kubernetes, Docker, Terraform/OpenTofu, and more
- 🐚 **Shell Configuration**: Zsh with Oh My Zsh, Powerlevel10k, and useful aliases
- 📝 **Neovim Setup**: NixVim with LSP, Telescope, and other plugins
- 🔐 **Security**: Touch ID for sudo, system hardening options
- ⚡ **Optimizations**: Fast key repeat, dock animations, and system tweaks

## Prerequisites

- macOS (tested on Apple Silicon, but Intel should work with modifications)
- Administrator access (for system configuration)
- Basic familiarity with terminal commands

## Installation

### Step 1: Install Nix

Choose one of the following installation methods:

#### Option A: Using Lix (Recommended)

[Lix](https://github.com/lix-project/lix) is a modern, community fork of Nix with improvements and fixes.

```bash
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
```

#### Option B: Using Determinate Systems Installer

[Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer) is the easiest and most reliable way to install Nix—as well as our longest-running project.


```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### Step 2: Source the Nix Environment

Apply the necessary Nix environment variables to your current shell session:

```bash
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

**Important**: If using a new terminal session, you may need to source this again, or restart your terminal.

Verify Nix is installed:

```bash
nix --version
```

### Step 3: Install Homebrew

Homebrew is used for GUI applications (Casks) that aren't available in nixpkgs:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After installation, add Homebrew to your PATH:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Step 4: Clone Configuration Repository

```bash
git clone https://github.com/jmutai/nixos-configs-mac.git
cd nixos-configs-mac
```

### Step 5: Update Hostname (Optional)

The configuration now supports dynamic hostname detection! Check your Mac's hostname:

```bash
scutil --get LocalHostName
```

**Automatic Detection (Recommended):**
- `darwin-rebuild` will automatically detect and use your system's hostname when you run `darwin-rebuild switch --flake .`
- Simply add your hostname to the `hostnames` list in `flake.nix` (see below)
- After adding it once, it will work automatically on subsequent builds

**Manual Configuration (If you have multiple machines):**
Edit `flake.nix` and add your hostname(s) to the `hostnames` list at the top of the `let` block:

```nix
hostnames = [
  "macbook-pro"  # Current hostname
  "Your-New-Hostname"     # Add additional hostnames here
];
```

HostName, LocalHostName and ComputerName can be changed from CLI:

```bash
sudo scutil --set HostName macbook-pro-m3
sudo scutil --set LocalHostName macbook-pro-m3
sudo scutil --set ComputerName "Mutai's MacBook Pro"
```

Confirm settings:

```bash
scutil --get HostName
scutil --get LocalHostName
scutil --get ComputerName
```

You may see different values, they each serve a slightly different purpose.

| Type           | Description                                         | Example                |
|----------------|-----------------------------------------------------|------------------------|
| **HostName**   | Used by network services (e.g., SSH, Terminal prompt). | `macbook-pro.local`    |
| **LocalHostName** | Used for Bonjour/AirDrop.                         | `macbook-pro`          |
| **ComputerName**  | Visible name in System Settings → General → Sharing. | `Josphat’s MacBook Pro` |


All configuration variables (hostnames, username) are now defined at the top of the `let` block for easy customization.

**Update Username:**
Edit `flake.nix` and change the `username` variable at the top of the `let` block:

```nix
username = "jkmutai";  # Change to your macOS username
```

The configuration will automatically use this username throughout the setup.

**Update Git Configuration:**
Edit `home.nix` and update the git user settings:

```nix
programs.git = {
  settings = {
    user = {
      name = "";  # Change to your git username
      email = "";  # Change to your git email
    };
    # ... rest of config
  };
};
```

This will configure your git identity globally for all repositories.

### Step 6: Initial Build

Run the initial build to apply your configuration:

```bash
sudo nix run nix-darwin -- switch --flake .
```

This will:
- Install all system packages
- Configure macOS settings
- Set up Home Manager
- Install GUI applications via Homebrew
- Configure your shell and development tools

**First build may take 20-30 minutes** depending on your internet connection and system.

### Step 7: Verify Installation

After the first build completes, verify everything is working:

```bash
# Test your update alias
update

# Check if packages are available
which nvim
which git
which kubectl

# Verify shell configuration
echo $SHELL  # Should show zsh
```

## Configuration Overview

This configuration uses:

- **nix-darwin**: System-level configuration and macOS settings
- **Home Manager**: User-level configuration and packages
- **Nix Flakes**: Modern Nix package management with locked dependencies
- **NixVim**: Neovim configuration managed in Nix

### Key Configuration Files

- `flake.nix`: Main flake configuration - inputs, outputs, and system setup
- `modules/packages.nix`: System packages installed via Nix
- `modules/homebrew.nix`: Homebrew casks (GUI applications)
- `modules/system-defaults.nix`: macOS system settings and preferences
- `modules/nix.nix`: Nix configuration settings
- `home.nix`: User configuration - shell, git, user packages
- `modules/aliases.nix`: Shell aliases (git, kubectl, docker, etc.)
- `nixvim.nix`: Neovim configuration - plugins, themes, LSP servers

## What's Included

### System Packages (via Nix)

- **Communication**: Slack, Zoom, Discord
- **Terminals**: Kitty, Alacritty, Tabby, Ghostty
- **Browsers**: Firefox
- **Development**: VS Code, GitHub CLI, Docker Compose, Lazydocker
- **Productivity**: Obsidian, Joplin Desktop
- **Editors**: Neovim, Vim
- **CLI Tools**: Git, curl, wget, tree, ripgrep, fzf, bat, eza, tmux
- **System Tools**: htop, btop, neofetch, ranger
- **Media**: Spotify

### GUI Applications (via Homebrew Cask)

- Cursor (editor)
- Brave, Vivaldi, Google Chrome
- iTerm2
- Notion
- Transmission, qBittorrent
- Docker Desktop, Podman Desktop
- Karabiner Elements
- Tailscale, Tunnelblick, Pritunl (VPN clients)
- Beekeeper Studio
- Microsoft Remote Desktop

### Development Tools (via Home Manager)

- **Kubernetes**: kubectl, k9s, Lens
- **Containers**: Podman, podman-compose
- **Infrastructure**: OpenTofu, Terragrunt, Ansible
- **Cloud**: Google Cloud SDK
- **Databases**: PostgreSQL, MariaDB
- **VPN**: OpenVPN, Tailscale, NetBird

### Shell Configuration

- **Zsh** with Oh My Zsh
- **Powerlevel10k** theme
- **Plugins**: git, docker, kubectl, terraform, macos, fzf, and more
- **Aliases**: Git shortcuts, kubectl aliases, Docker/Podman shortcuts, Terraform/OpenTofu shortcuts
- **Modern Tools**: eza (ls), bat (cat), fzf (fuzzy finder)

### Neovim Configuration

- **Theme**: Catppuccin
- **Plugins**: Lualine, nvim-tree, Telescope, Treesitter
- **LSP**: Nix (nil-ls), Lua (lua-ls)
- **Features**: Syntax highlighting, file tree, fuzzy finder, status bar

### macOS System Settings

- **Dock**: Auto-hide, left position, optimized animations
- **Finder**: Show extensions, path bar, list view
- **Keyboard**: Caps Lock → Control, fast key repeat
- **Trackpad**: Tap to click, three-finger drag
- **Security**: Touch ID for sudo, guest account disabled
- **Screenshots**: PNG format, saved to `~/Pictures/Screenshots`

## Usage

### Common Commands

```bash
# Update system configuration
update

# Update and rebuild with latest flake inputs
upgrade

# Clean up old Nix generations
cleanup

# Rebuild configuration (if you're already in the config directory)
sudo darwin-rebuild switch --flake .
```

### Useful Aliases

See `home.nix` for a complete list, but here are some highlights:

**Git:**
- `g` = git
- `gs` = git status
- `ga` = git add
- `gc` = git commit
- `gp` = git push

**Kubernetes:**
- `k` = kubectl
- `kgp` = kubectl get pods
- `kl` = kubectl logs
- `kexec` = kubectl exec -it

**Docker/Podman:**
- `d` = docker
- `dc` = docker-compose
- `p` = podman
- `pc` = podman-compose

**Terraform/OpenTofu:**
- `tf` = tofu
- `tg` = terragrunt
- `tgaa` = terragrunt apply -auto-approve

## Customization

### Adding Packages

**System packages** (available to all users):
Edit `modules/packages.nix` and add to `environment.systemPackages`:

```nix
environment.systemPackages = with pkgs; [
  # ... existing packages
  your-package-name
];
```

**User packages** (specific to your user):
Edit `home.nix` and add to `home.packages`:

```nix
home.packages = with pkgs; [
  # ... existing packages
  your-package-name
];
```

**Homebrew Casks** (GUI applications):
Edit `modules/homebrew.nix` and add to `homebrew.casks`:

```nix
homebrew = {
  casks = [
    # ... existing casks
    "your-app-name"
  ];
};
```

After making changes, rebuild:

```bash
update
```

### Changing Shell Configuration

Edit `home.nix` for shell plugins and settings:
- **Oh My Zsh plugins**: Edit `programs.zsh.oh-my-zsh.plugins`
- **Custom shell functions**: Add to `programs.zsh.initContent`

**Shell aliases** are now in `modules/aliases.nix`:
- Edit `modules/aliases.nix` to add, modify, or remove aliases
- This keeps all aliases organized in one place

### Changing Git Configuration

Edit `home.nix` under `programs.git.settings.user`:
- **Name**: Change `user.name` to your git username
- **Email**: Change `user.email` to your git email
- **Aliases**: Add custom git aliases under `alias.*`
- **Editor**: Change `core.editor` if you prefer a different editor

### Changing Neovim Configuration

Edit `nixvim.nix`:
- **Theme**: Change `colorschemes.*.enable`
- **Plugins**: Add to `plugins.*`
- **Options**: Modify `opts.*`

### Changing macOS Settings

Edit `modules/system-defaults.nix`:
- Dock settings: `system.defaults.dock.*`
- Finder settings: `system.defaults.finder.*`
- Keyboard settings: `system.defaults.NSGlobalDomain.*`
- Trackpad settings: `system.defaults.trackpad.*`

## Project Structure

```
nixos-configs-mac/
├── flake.nix          # Main flake configuration with inputs and outputs
├── flake.lock         # Locked dependencies (auto-generated)
├── home.nix           # User configuration: shell, git, user packages
├── nixvim.nix         # Neovim configuration: plugins, themes, LSP
├── modules/           # Modular configuration files
│   ├── packages.nix      # System packages (Nix)
│   ├── homebrew.nix      # Homebrew casks (GUI apps)
│   ├── system-defaults.nix # macOS system settings
│   ├── nix.nix            # Nix configuration settings
│   └── aliases.nix        # Shell aliases (git, kubectl, docker, etc.)
└── README.md          # This file
```

**Benefits of this modular structure:**
- **Better organization**: Each file has a single, clear purpose
- **Easier maintenance**: Find and edit specific configurations quickly
- **Cleaner files**: Main config files are more readable
- **Scalable**: Easy to add new modules as your configuration grows

## Troubleshooting

### Build Fails

**Issue**: `error: flake.nix:xxx:xxx: undefined variable`

**Solution**: Make sure all flake inputs are properly defined. Run:
```bash
nix flake update
```

**Issue**: `error: cannot connect to socket`

**Solution**: Make sure the Nix daemon is running:
```bash
sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist
```

### Packages Not Found

**Issue**: Package not available after installation

**Solution**: 
1. Check if the package name is correct in nixpkgs
2. Rebuild: `update`
3. Start a new terminal session

### Homebrew Apps Not Installing

**Issue**: Homebrew casks not installing

**Solution**:
1. Verify Homebrew is installed: `which brew`
2. Check if the cask name is correct: `brew search <app-name>`
3. Manually install to verify: `brew install --cask <app-name>`

### Shell Not Working

**Issue**: Zsh configuration not loading

**Solution**:
1. Verify zsh is your default shell: `echo $SHELL`
2. Check if home.nix is properly imported in flake.nix
3. Rebuild: `update`
4. Source your shell config: `source ~/.zshrc`

### Permission Errors

**Issue**: `sudo: ... command not found` or permission denied

**Solution**: 
- Make sure you're using `sudo` for system-level changes
- Verify your user has sudo privileges
- Check file permissions if editing files directly

### Out of Disk Space

**Issue**: Nix store growing too large

**Solution**: Run cleanup regularly:
```bash
cleanup  # or: nix-collect-garbage -d
```

You can also adjust the garbage collection settings in `flake.nix`:
```nix
nix.gc = {
  automatic = true;
  interval = { Weekday = 7; };  # Run on Sundays
  options = "--delete-older-than 30d";  # Keep last 30 days
};
```

## Maintenance

### Regular Updates

**Update packages and configuration:**
```bash
upgrade
```

This updates all flake inputs and rebuilds your system.

**Update just packages (keep flake inputs locked):**
```bash
update
```

### Cleanup Old Generations

Nix keeps old system generations for rollback. Clean them up periodically:

```bash
cleanup
```

Or manually:
```bash
nix-collect-garbage -d
```

### Backup Configuration

Your configuration is already version controlled! Just commit and push:

```bash
git add .
git commit -m "Update configuration"
git push
```

### Rollback

If something goes wrong, you can rollback to a previous generation:

```bash
sudo darwin-rebuild switch --rollback
```

Or list all generations:
```bash
sudo darwin-rebuild --list-generations
```

Then switch to a specific generation:
```bash
sudo darwin-rebuild switch --rollback <generation-number>
```

## Personal notes

```bash
ln -sfn ~/.cheats/.p10k.zsh ~/.p10k.zsh
ln -sfn ~/.cheats/.p10k.zsh ~/.config/p10k.zsh
rm -rf ~/.ssh
ln -sfn ~/.cheats/.ssh/ ~/.ssh
```
## Additional Resources

- [nix-darwin Documentation](https://github.com/nix-darwin/nix-darwin)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [NixOS Wiki](https://nixos.wiki/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [NixVim Documentation](https://github.com/nix-community/nixvim)

## License

This configuration is for personal use. Feel free to fork and adapt for your needs!

---

**Note**: This configuration is tailored for Apple Silicon Macs. If you're on Intel, change `hostPlatform` in `flake.nix` from `"aarch64-darwin"` to `"x86_64-darwin"`.
