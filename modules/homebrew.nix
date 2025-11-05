{
  # Homebrew for GUI apps and things not in nixpkgs
  homebrew = {
    enable = true;
    
    # Apps installed from Homebrew Cask
    casks = [
      "cursor"
      "vivaldi"
      "google-chrome"
      "iterm2"
      "notion"
      "transmission"
      "qbittorrent"
      "docker-desktop"
      "podman-desktop"
      "karabiner-elements"
      "tailscale-app"
      "tunnelblick"
      "beekeeper-studio"
      "microsoft-remote-desktop"
      "pritunl"
      "ghostty"
    ];
    
    # Cleanup old versions
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}

