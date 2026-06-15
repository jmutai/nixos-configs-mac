{ config, pkgs, ... }:

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
    nerd-fonts.hack
  ];

  environment.systemPackages = (with pkgs; [
    # Communication
    slack
    zoom-us
    discord
    # teams

    # Shell, Terminals
    nushell
    kitty
    alacritty

    # Browsers
    firefox

    # Development Tools
    gh
    docker-compose
    lazydocker
    devbox

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
    btop   # Modern alternative to top
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
    eza      # Better ls
    tmux
    iproute2mac
    fd

    # File management
    ranger

    # Screenshot tools
    flameshot

    # languages and runtimes
    python3
    go
    php
    phpPackages.composer
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
    nixpkgs-fmt

    # Media
    aria2
    yt-dlp
    ffmpeg
    git-crypt
    nil
    nixd

    # Virtualization
    vagrant
    packer

    # VPN
    openvpn
  ]);

  home-manager.users.${config.system.primaryUser} = {
  home.packages = with pkgs; [
    # CLI helpers
    nnn
    zsh-completions

    # Productivity

    # Containerization
    kubectl
    kubernetes-helm
    kustomize

    # Infrastructure as Code
    crossplane-cli
    ansible
    opentofu
    terragrunt
    terraform-docs
    tflint
    infracost
    # checkov  # Temporarily disabled due to pyarrow build issue
    tfsec
    terrascan
    hcledit
    # pre-commit  # Temporarily disabled due to Swift build issues with clang 21.1.8
    gitleaks
    trivy
    graphviz
    tfupdate

    # Secrets management
    sops
    age


    # Container tools
    podman
    podman-compose
    k9s
    lens

    # Cloud CLI tools; gcloud components list
    awscli
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])

    # Database clients
    postgresql
    mariadb

    # VPN clients
    openvpn    # OpenVPN CLI
    tailscale  # Tailscale CLI
  ];

  # Global CLIs that are NOT in nixpkgs: uv-managed tools + npm globals.
  # Installed declaratively on every `darwin-rebuild switch` so a fresh machine
  # is reproducible from one `update`. Idempotent (uv/npm skip already-installed);
  # errors are swallowed so a network blip never fails the rebuild.
  # Literal DAG attrset == lib.hm.dag.entryAfter ["installPackages"] (no lib.hm needed here).
  home.activation.cliTools = {
    after = [ "installPackages" ];
    before = [ ];
    data = ''
      # uv tools (isolated venvs under ~/.local/share/uv/tools)
      for t in mlx-whisper vastai vncdotool ssh-audit aider-chat kimi-cli; do
        ${pkgs.uv}/bin/uv tool install --quiet "$t" || true
      done
      # npm globals (node is Homebrew-managed; its global prefix is /opt/homebrew)
      if [ -x /opt/homebrew/bin/npm ]; then
        for n in @google/gemini-cli @openai/codex wrangler @salesforce/cli; do
          /opt/homebrew/bin/npm install -g --silent "$n" || true
        done
      fi
    '';
  };
  };

  homebrew = {
    enable = true;

    brews = [
      "argocd"
      "xz"
      "zlib"
      "gnupg"
      "macos-trash"
      "git-lfs"
      "cmake"
      "nmap"
      "node"
      "pngquant"
      "oxipng"
      "act"
      "telnet"
      "mise"
      "just"
      "qemu"
      "grpcurl"
      "netbirdio/tap/netbird"
      "yt-dlp"
      "maven"
      "openjdk"
      "anomalyco/tap/opencode"
      "poppler"   # pdftoppm/pdfinfo/pdftotext — PDF tooling (was an untracked leaf; zap would remove it)
    ];

    taps = [
      "FelixKratz/formulae"
      "mrkai77/cask"
      "keith/formulae"
      "mmazzarolo/formulae"
      "supabase/tap"
      "anomalyco/tap"
      "manaflow-ai/cmux"
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
      "tabby"
      "virtualbox"
      "spotify"
      "keepassxc"
      "vnc-viewer"
      "tigervnc"
      "balenaetcher"
      "netbirdio/tap/netbird-ui"
      "mark-text"
      "manaflow-ai/cmux/cmux"
      "antigravity"
      #"claude-code" # installed via npm: npm install -g @anthropic-ai/claude-code
      # "codex"  # installed via npm: @openai/codex
      # "openclaw"
      # "dia"
    ];

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    # Homebrew >=5.1 requires --force with `brew bundle install --cleanup`
    onActivation.extraFlags = [ "--force" ];
  };

}

