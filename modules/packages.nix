{ pkgs, ... }:

{
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Communication
    slack
    zoom-us
    discord

    # Terminals
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
    
    # System monitoring
    htop
    btop  # Modern alternative to htop
    
    # Essential CLI tools
    neofetch 
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
  ];
}

