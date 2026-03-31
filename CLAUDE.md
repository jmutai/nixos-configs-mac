# Nix-Darwin macOS Configuration

## Overview
Declarative macOS system config using nix-darwin + Home Manager + Flakes on Apple Silicon.
User: `jkmutai`, Hosts: `macbook-pro-3`, `jkm-macbook-pro-4`.

## Build Commands
- `update` — rebuild from current config (alias in shell)
- `upgrade` — `nix flake update` + rebuild
- `cleanup` — garbage collect old generations
- After editing any .nix file, run: `sudo darwin-rebuild switch --flake .`
- New files MUST be `git add`-ed before rebuild (flakes require tracked files)

## Structure
- `flake.nix` — entry point, inputs, overlays, multi-host config
- `home.nix` — imports all user program modules (add new modules here)
- `modules/packages.nix` — system pkgs (nix), user pkgs (nix), homebrew (brews/casks/taps)
- `modules/system-settings.nix` — macOS defaults (dock, finder, keyboard, trackpad)
- `modules/nix-core.nix` — nix daemon settings, gc, optimization
- `modules/aliases.nix` — all shell aliases (imported by zsh.nix)
- `modules/home/theme.nix` — Edo color theme (used by all terminals)
- `modules/home/programs/*.nix` — per-program configs

## Key Patterns
- **Theme**: Import with `let theme = import ../theme.nix; c = theme.colors;`
- **Strip hex #**: Use `strip = theme.rawHexValue;` then `${strip c.red}`
- **Aliases**: Plain nix attrset in `modules/aliases.nix`, auto-loaded by zsh
- **New program**: Create `modules/home/programs/foo.nix`, add import to `home.nix`
- **Homebrew GUI apps** go in `casks`, CLI tools in `brews`, custom sources need a `tap`
- **System packages** (all users): `environment.systemPackages` in packages.nix
- **User packages** (jkmutai only): `home-manager.users.*.home.packages` in packages.nix

## Conventions
- Commit style: lowercase, imperative, concise ("add X package", "fix Y", "rm Z")
- Font standard: JetBrainsMono Nerd Font, size 14
- Terminal standard: Edo theme, 92% opacity, blur 20-30, block cursor
- All terminals share same keybindings where possible (Cmd+D split, Cmd+Alt+Arrow navigate)
- Disabled packages are commented with reason: `# checkov  # Temporarily disabled due to...`

## Gotchas
- `onActivation.cleanup = "zap"` removes any Homebrew app NOT in the casks list
- Terragrunt has a custom overlay in flake.nix (build fix)
- `electron-36.9.5` is permitted insecure in nixpkgs config
- Empty dirs at `~/.config/<app>/` can block home-manager symlinks — delete them
