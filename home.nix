{ config, pkgs, lib ? pkgs.lib, pwaerospace, sketchybar-config, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in {
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
  ];
  # Home Manager needs a bit of information about you and the paths it should manage
  home.stateVersion = "25.05";

  launchd.agents = {
    aerospace = {
      enable = true;
      config = {
        ProgramArguments = [
          (lib.getExe pwaerospace.packages.${system}.aerospace-standalone)
        ];
        RunAtLoad = true;
        KeepAlive = false;
        StandardOutPath = "/tmp/aerospace.log";
        StandardErrorPath = "/tmp/aerospace.error.log";
      };
    };

    sketchybar = {
      enable = true;
      config = {
        ProgramArguments = [
          (lib.getExe sketchybar-config.packages.${system}.sketchybar-standalone)
        ];
        RunAtLoad = true;
        KeepAlive = false;
        StandardOutPath = "/tmp/sketchybar.log";
        StandardErrorPath = "/tmp/sketchybar.error.log";
      };
    };
  };
}
