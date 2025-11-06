{
  # Homebrew for GUI apps and things not in nixpkgs
  homebrew = {
    enable = true;
    
    # Apps installed from Homebrew
    brews = [
        "xz"
        "zlib"
        "gnupg"
        "git-lfs"
        "cmake"
        "nmap"
        "node"
    ];
    casks = [
      "cursor"
      "visual-studio-code"
      "vivaldi"
      "google-chrome"
      "brave-browser"
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
      "zed"
      "motrix"
    ];
    
    # Cleanup old versions
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}

