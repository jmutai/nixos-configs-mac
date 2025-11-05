## What is nix-darwin?

nix-darwin is a tool that lets you manage your macOS system configuration declaratively using Nix. You can version control your entire system setup, making it reproducible and easy to replicate across machines.

## Step 1 Install Nix

### Using Lix
- Lix is a modern, delicious implementation of the Nix package manager, focused on correctness, usability, and growth – and committed to doing right by its community.
- it's a community fork of Nix with some improvements and fixes.

```bash
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
```

### Using Determinate Systems installer

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

## Source the Nix daemon profile script

To apply the necessary Nix environment variables to your current shell session, run the following command:

```bash
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

 Verify Nix is installed:

 ```bash
 nix --version
 ```

## Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Clone your configuration repository

```bash
git clone
cd nixos-configs-mac
```

Update hostname in flake.nix (if needed)

```bash
# Check your new Mac's hostname
hostname

# If different from "Josphats-MacBook-Pro", edit flake.nix
# vim flake.nix
# Change: darwinConfigurations."Josphats-MacBook-Pro" 
# To: darwinConfigurations."Your-New-Hostname"
```

## Initial build

```bash
nix run nix-darwin -- switch --flake .
```

After the first build completes, everything is installed and configured:

- Your update alias works
- All packages installed
- All settings applied
- Shell configured

```bash
# Test your alias
update
```

