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
    ./modules/home/programs/cmux.nix
    ./modules/home/programs/kitty.nix
    ./modules/home/programs/iterm2.nix
    ./modules/home/programs/tabby.nix
    ./modules/home/programs/cursor.nix
    ./modules/home/programs/antigravity.nix
    ./modules/home/programs/python.nix
    ./modules/home/programs/claude.nix
  ];

  # Create Screenshots directory for macOS screenshots
  # Use activation script to ensure directory exists and has correct permissions
  home.activation.createScreenshotsDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/Pictures/Screenshots"
    chmod 755 "$HOME/Pictures/Screenshots" 2>/dev/null || true
  '';

  # Global git pre-commit hook — gitleaks secret scanning on every commit
  home.file.".config/git/hooks/pre-commit" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Global pre-commit hook: gitleaks secret scanning
      # Managed by nix-darwin — edit in home.nix

      if ! command -v gitleaks &>/dev/null; then
        echo "⚠ gitleaks not found, skipping secret scan"
        exit 0
      fi

      # Scan only staged changes (fast)
      gitleaks git --pre-commit --staged --verbose
      exit_code=$?

      if [ $exit_code -ne 0 ]; then
        echo ""
        echo "🚫 Secret detected in staged files! Commit blocked."
        echo ""
        echo "To inspect:  gitleaks git --pre-commit --staged --verbose"
        echo "To bypass:   git commit --no-verify  (use with caution)"
        exit 1
      fi
    '';
  };

  # Home Manager needs a bit of information about you and the paths it should manage
  home.stateVersion = "25.05";
}
