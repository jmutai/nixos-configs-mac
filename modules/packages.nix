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
    vscode
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

    # File management
    ranger

    # Screenshot tools
    flameshot
    
    # Development tools
    jq
    yq
    gnused
    coreutils

    # Media
    spotify
  ];
}

