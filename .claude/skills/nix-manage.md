---
name: nix-manage
description: Manage nix-darwin macOS configuration — add/remove packages, aliases, programs, themes, homebrew apps, system settings, and rebuild.
user_invocable: true
---

# Nix-Darwin Configuration Manager

You are managing a nix-darwin + Home Manager configuration at:
`/Users/jkmutai/Library/Mobile Documents/com~apple~CloudDocs/projects/nixos-configs-mac`

## What you can do

Based on the user's request, perform ONE of these operations:

### 1. Add/Remove Packages
- **Nix system packages**: Edit `modules/packages.nix` → `environment.systemPackages`
- **Nix user packages**: Edit `modules/packages.nix` → `home-manager.users.*.home.packages`
- **Homebrew CLI tools**: Edit `modules/packages.nix` → `homebrew.brews`
- **Homebrew GUI apps**: Edit `modules/packages.nix` → `homebrew.casks`
- **Homebrew taps**: Add to `homebrew.taps` if package uses `org/tap/name` format
- Search nixpkgs first: `nix search nixpkgs <name>`. Prefer nix over homebrew when available.
- WARN: `onActivation.cleanup = "zap"` removes any Homebrew app NOT listed — never remove without asking.

### 2. Add/Remove Aliases
- Edit `modules/aliases.nix`
- Format: `alias-name = "command";`
- Grouped by category with comments
- For `cd` aliases with spaces in path, escape with `\\`

### 3. Configure a Program
- Create or edit `modules/home/programs/<name>.nix`
- If NEW file: add import to `home.nix` AND run `git add` on the file before rebuild
- Use Home Manager module options when available (`programs.<name>.enable = true`)
- For macOS apps without HM modules, use `home.file` or `xdg.configFile`
- Apply Edo theme: `let theme = import ../theme.nix; c = theme.colors;`

### 4. Terminal Configuration
All terminals follow these standards:
- **Font**: JetBrainsMono Nerd Font, size 14
- **Theme**: Edo from `modules/home/theme.nix`
- **Opacity**: 0.92, blur: 20
- **Cursor**: block
- **Scrollback**: 50000
- **Keybindings**: Cmd+D (vsplit), Cmd+Shift+D (hsplit), Cmd+Alt+Arrow (navigate), Cmd+K (clear)

Terminals: kitty.nix, ghostty.nix, tabby.nix, iterm2.nix

### 5. System Settings
- Edit `modules/system-settings.nix`
- macOS defaults under `system.defaults.*` (dock, finder, NSGlobalDomain, trackpad, etc.)

### 6. Theme Changes
- Edit `modules/home/theme.nix` to change the Edo palette
- Colors propagate to all terminals automatically on rebuild
- Helpers: `rawHexValue` (strips #), `hexToRgb` (converts to RGB object)

## After making changes

Always rebuild:
```bash
# If new files were created:
git add <new-file>

# Rebuild:
cd "/Users/jkmutai/Library/Mobile Documents/com~apple~CloudDocs/projects/nixos-configs-mac"
sudo darwin-rebuild switch --flake .
```

Check the output for errors. Common issues:
- **File not found**: New .nix file not `git add`-ed
- **Homebrew binary conflict**: Binary already exists from another source (npm, pip, etc.)
- **Permission denied for apps**: Grant App Management permission in System Settings
- **Empty config dir blocking symlink**: Remove the empty directory

## Key file locations
```
flake.nix                          # Inputs, overlays, host definitions
home.nix                           # Program module imports
modules/packages.nix               # All packages (nix + homebrew)
modules/aliases.nix                # Shell aliases
modules/system-settings.nix        # macOS preferences
modules/nix-core.nix               # Nix daemon config
modules/home/theme.nix             # Edo color palette
modules/home/programs/*.nix        # Per-program configs
```
