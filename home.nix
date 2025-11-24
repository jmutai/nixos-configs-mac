{ config, pkgs, lib ? pkgs.lib, ... }:
{
  imports = [
    ./nixvim.nix
    ./modules/home/programs/zsh.nix
    ./modules/home/programs/clock-rs.nix
    ./modules/home/programs/git.nix
    ./modules/home/programs/bat.nix
    ./modules/home/programs/fzf.nix
    ./modules/home/programs/tmux.nix
    ./modules/home/programs/htop.nix
    ./modules/home/programs/ghostty.nix
    ./modules/home/programs/tabby.nix
    ./modules/home/programs/cursor.nix
    ./modules/home/programs/antigravity.nix
  ];

  # Create Screenshots directory for macOS screenshots
  # Use activation script to ensure directory exists and has correct permissions
  home.activation.createScreenshotsDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/Pictures/Screenshots"
    chmod 755 "$HOME/Pictures/Screenshots" 2>/dev/null || true
  '';

  # Home Manager needs a bit of information about you and the paths it should manage
  home.stateVersion = "25.05";
}
