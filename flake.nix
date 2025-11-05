{
  description = "My nix-darwin system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, agenix, nixvim }:
  let
    configuration = { pkgs, ... }: {
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

      # IMPORTANT: Set primary user for system defaults
      system.primaryUser = "jkmutai";

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

        ];
        
        # Cleanup old versions
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      # Enable touch ID for sudo - UPDATED option name
      security.pam.services.sudo_local.touchIdAuth = true;

      # Fonts
      fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        nerd-fonts.meslo-lg
      ];
      # font style set in cursor: Open Settings (Cmd+,), features-terminal, settings.json, add "terminal.integrated.fontFamily": "'MesloLGS Nerd Font'",

      # System settings and optimizations
      system = {
        defaults = {
          # Dock settings
          dock = {
            autohide = true;
            autohide-delay = 0.0;
            autohide-time-modifier = 0.2;
            expose-animation-duration = 0.1;
            tilesize = 48;
            launchanim = false;
            show-recents = false;
            show-process-indicators = true;
            orientation = "left";
            mru-spaces = false;  # Don't rearrange spaces
          };

          # Finder settings
          finder = {
            AppleShowAllExtensions = true;
            AppleShowAllFiles = false;
            ShowPathbar = true;
            ShowStatusBar = true;
            FXEnableExtensionChangeWarning = false;
            FXPreferredViewStyle = "Nlsv";  # List view
            _FXShowPosixPathInTitle = true;
          };

          # Login window settings
          loginwindow = {
            GuestEnabled = false;
            DisableConsoleAccess = true;
          };

          # Global macOS settings
          NSGlobalDomain = {
            # Keyboard settings
            ApplePressAndHoldEnabled = false;  # Enable key repeat
            InitialKeyRepeat = 15;  # Fast key repeat
            KeyRepeat = 2;          # Very fast key repeat
            
            # Interface settings
            AppleShowAllExtensions = true;
            AppleShowAllFiles = false;
            
            # Disable automatic features
            NSAutomaticCapitalizationEnabled = false;
            NSAutomaticDashSubstitutionEnabled = false;
            NSAutomaticPeriodSubstitutionEnabled = false;
            NSAutomaticQuoteSubstitutionEnabled = false;
            NSAutomaticSpellingCorrectionEnabled = false;
            
            # Window animations
            NSWindowResizeTime = 0.001;
            
            # Expand save and print panels by default
            NSNavPanelExpandedStateForSaveMode = true;
            NSNavPanelExpandedStateForSaveMode2 = true;
            PMPrintingExpandedStateForPrint = true;
            PMPrintingExpandedStateForPrint2 = true;
          };

          # Trackpad settings
          trackpad = {
            Clicking = true;  # Tap to click
            TrackpadThreeFingerDrag = true;
          };

          # Screenshot settings
          screencapture = {
            location = "~/Pictures/Screenshots";
            type = "png";
            disable-shadow = true;
          };

          # Custom user preferences
          CustomUserPreferences = {
            # Disable annoying features
            "com.apple.AdLib" = {
              allowApplePersonalizedAdvertising = false;
            };
            
            # Speed up Mission Control animations
            "com.apple.dock" = {
              expose-animation-duration = 0.1;
            };
          };
        };

        # Keyboard settings
        keyboard = {
          enableKeyMapping = true;
          remapCapsLockToControl = true;  # Remap Caps Lock to Control
        };

        # Set macOS version
        stateVersion = 5;
      };

      # Nix settings
      nix = {
        settings = {
          experimental-features = "nix-command flakes";
          # Build settings
          max-jobs = 8;
          cores = 0;  # Use all available cores
        };
        
        # UPDATED: Use nix.optimise.automatic instead of auto-optimise-store
        optimise.automatic = true;
        
        # Garbage collection
        gc = {
          automatic = true;
          interval = { Weekday = 7; };  # Run on Sundays
          options = "--delete-older-than 30d";
        };
      };

      # The platform
      nixpkgs = {
        hostPlatform = "aarch64-darwin";  # Change to x86_64-darwin for Intel
        config = {
          allowUnfree = true;  # Allow proprietary software
        };
      };

      # User configuration
      users.users.jkmutai = {
        name = "jkmutai";
        home = "/Users/jkmutai";
        shell = pkgs.zsh;
      };
    };
  in
  {
    # Build darwin flake using:
    # $ cd /etc/nix-darwin && sudo nix run nix-darwin/master#darwin-rebuild -- switch
    darwinConfigurations."Josphats-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration 
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jkmutai = import ./home.nix;
          home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
        }
      ];
    };

    # Expose the package set, including overlays, for convenience
    darwinPackages = self.darwinConfigurations."Josphats-MacBook-Pro".pkgs;
    system.activationScripts.extraActivation.text = ''
      mkdir -p ~/Pictures/Screenshots
    '';
  };
}
