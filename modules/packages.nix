{ config, pkgs, pwaerospace, sketchybar-config, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in {
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-36.9.5"
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
  ];

  environment.systemPackages =
    [
      pwaerospace.packages.${system}.aerospace-standalone
      sketchybar-config.packages.${system}.sketchybar-standalone
    ]
    ++ (with pkgs; [

      # Desktop
      sketchybar-app-font
    
    # Communication
    slack
    zoom-us
    discord

    # Shell, Terminals
    nushell
    kitty
    alacritty
    tabby

    # Browsers
    firefox
    
    # Development Tools
    gh
    docker-compose
    lazydocker

    # Productivity
    lazygit
    fish
    direnv
    obsidian

    # Note-taking and documentation
    joplin-desktop

    # Editors
    neovim
    vim

    # Shell tools
    zsh
    zsh-completions
    bash-completion
        
    # Essential CLI tools
    htop
    btop # Modern alternative to htop
    bottom # Modern alternative to htop
    zellij
    neofetch 
    fastfetch
    git
    curl
    wget
    tree
    ripgrep  # Fast grep alternative
    fzf      # Fuzzy finder
    bat      # Better cat
    eza      # Better ls
    tmux
    iproute2mac

    # File management
    ranger

    # Screenshot tools
    flameshot
    
    # languages and runtimes
    python3
    go
    pipx
    uv
    yarn
    jq
    yq
    gnused
    coreutils
    meson
    act
    lua

      # Media
      aria2
      yt-dlp
      ffmpeg
      spotify
      git-crypt
    ]);

  home-manager.users.${config.system.primaryUser}.home.packages = with pkgs; [
    nnn
    zsh-completions

    # Containerization
    kubectl
    kubernetes-helm
    kustomize

    # Infrastructure as Code
    ansible
    opentofu
    terragrunt

    # Container tools
    podman
    podman-compose
    k9s
    lens

    # Cloud CLI tools; gcloud components list
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])

    # Database clients
    postgresql
    mariadb

    # VPN clients
    openvpn    # OpenVPN CLI
    tailscale  # Tailscale CLI
    netbird    # NetBird CLI
  ];

  homebrew = {
    enable = true;

    brews = [
      "xz"
      "zlib"
      "gnupg"
      "macos-trash"
      "git-lfs"
      "cmake"
      "nmap"
      "node"
      "pngquant"
    ];

    taps = [
      "FelixKratz/formulae"
      "mrkai77/cask"
      "keith/formulae"
      "mmazzarolo/formulae"
      "supabase/tap"
    ];

    casks = [
      "cursor"
      "visual-studio-code"
      "vivaldi"
      "google-chrome"
      "brave-browser"
      "microsoft-edge"
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
      "font-maple-mono"
      "font-maple-mono-nf"
      "font-sf-mono"
      "font-sf-pro"
      "sf-symbols"
    ];

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

}

