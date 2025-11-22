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
  ];
  # Home Manager needs a bit of information about you and the paths it should manage
  home.stateVersion = "25.05";
}
