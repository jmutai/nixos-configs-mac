{ config, lib, pkgs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
  primaryUser = config.system.primaryUser;
  # Lowercased tap names == brew's canonical form for its trust store.
  trustStoreJson = builtins.toJSON {
    trustedtaps = map (t: lib.toLower t.name) config.homebrew.taps;
  };
in {
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-36.9.5"
  ];

  # Silence Homebrew's "Hide these hints with HOMEBREW_NO_ENV_HINTS" nags
  # (applies to manual brew runs too, not just the rebuild bundle step).
  environment.variables.HOMEBREW_NO_ENV_HINTS = "1";

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
    ripgrep
    fzf
    eza
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
    cheat              # cheatsheet tool; configured in programs/cheat.nix

    # Containerization
    kubectl
    kubernetes-helm
    kustomize

    # Infrastructure as Code
    # NOTE: most of the IaC stack (opentofu, terragrunt, ansible, terraform-docs,
    # terrascan, tfsec, hcledit, tfupdate, crossplane, trivy) moved to Homebrew
    # (see `brews` below) — nixpkgs-unstable lagged behind upstream (e.g. terragrunt
    # was stuck at 0.97 vs 1.0.x). brew tracks latest. These two stay on nix because
    # they're current and brew's formulae are unreliable/equal:
    tflint
    infracost
    # checkov  # Temporarily disabled due to pyarrow build issue
    # pre-commit  # Temporarily disabled due to Swift build issues with clang 21.1.8
    gitleaks   # kept on nix: also backs the git pre-commit hook (home.nix)
    graphviz

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
    mongosh

    # VPN clients
    openvpn
    tailscale
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

  # Seed Homebrew's tap-trust store BEFORE `brew bundle` runs. In nix-darwin's
  # activation order the `homebrew` phase runs before `postActivation` (where
  # home-manager activates), so home-manager can't own this file. brew also rejects
  # a symlinked or non-user-owned trust store, and rewrites it during install via
  # `Trust.trust!` — so it must be a real, user-owned, 0600 regular file, written
  # here as root then chowned to the user. Derived from homebrew.taps (below) so the
  # two can't drift; adding a tap automatically trusts it on the next rebuild.
  # Idempotent — runs every `darwin-rebuild`.
  system.activationScripts.extraActivation.text = ''
    printf >&2 'seeding Homebrew tap-trust store...\n'
    userHome=$(/usr/bin/dscl . -read "/Users/"${lib.escapeShellArg primaryUser} NFSHomeDirectory 2>/dev/null | /usr/bin/awk '{print $NF}')
    [ -n "$userHome" ] || userHome="/Users/"${lib.escapeShellArg primaryUser}
    /usr/bin/install -d -o ${lib.escapeShellArg primaryUser} -g staff -m 0755 "$userHome/.homebrew"
    rm -f "$userHome/.homebrew/trust.json"   # drop any stale home-manager symlink / old file
    printf '%s\n' ${lib.escapeShellArg trustStoreJson} > "$userHome/.homebrew/trust.json"
    chown ${lib.escapeShellArg primaryUser}:staff "$userHome/.homebrew/trust.json"
    chmod 0600 "$userHome/.homebrew/trust.json"
  '';

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

      # Infrastructure as Code — on brew to track latest (nixpkgs-unstable lags upstream)
      "opentofu"
      "terragrunt"
      "ansible"
      "terraform-docs"
      "terrascan"
      "tfsec"          # NOTE: EOL upstream (merged into trivy) — kept for parity
      "hcledit"
      "tfupdate"
      "trivy"
      "crossplane"     # crossplane CLI (was crossplane-cli in nixpkgs)
    ];

    # Homebrew 6.0 gates non-official taps behind a trust check. The trust store
    # (~/.homebrew/trust.json) is written from this list by the extraActivation
    # script above, before `brew bundle` runs — no manual `brew trust` is ever
    # needed, fresh machines included. Keep every non-official tap here (incl.
    # netbirdio/tap for the netbird brew) so it gets trusted.
    taps = [
      "FelixKratz/formulae"
      "mrkai77/cask"
      "keith/formulae"
      "mmazzarolo/formulae"
      "supabase/tap"
      "anomalyco/tap"
      "manaflow-ai/cmux"
      "netbirdio/tap"
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
      "antigravity"      # "Google Antigravity" agent orchestration platform -> Antigravity.app
      "antigravity-ide"  # "Google Antigravity IDE" (separate product) -> Antigravity IDE.app
      #"claude-code" # installed via npm: npm install -g @anthropic-ai/claude-code
      # "codex"  # installed via npm: @openai/codex
      # "openclaw"
      # "dia"
    ];

    onActivation.cleanup = "zap";
    # autoUpdate = false keeps `darwin-rebuild` quiet and fast: it sets
    # HOMEBREW_NO_AUTO_UPDATE=1, so brew skips the "Auto-updating..." step and
    # the New Formulae/New Casks dumps. `upgrade = true` still upgrades against
    # the last-fetched formula data. Refresh manually with `brew update` (or the
    # `upgrade` alias) when you want newer formulae.
    onActivation.autoUpdate = false;
    onActivation.upgrade = true;
    # Homebrew >=5.1 requires --force with `brew bundle install --cleanup`
    onActivation.extraFlags = [ "--force" ];
  };

}

