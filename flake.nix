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
    # ============================================================================
    # Configuration Variables - Edit these to customize your setup
    # ============================================================================
    
    # List of hostnames to generate configurations for
    # Add your hostnames here - darwin-rebuild will automatically use the correct one
    # You can check your hostname with: hostname
    hostnames = [
      "Josphats-MacBook-Pro"  # Current hostname
      # Add more hostnames here as needed, e.g.:
      # "My-MacBook-Pro"
      # "Work-MacBook"
    ];

    # Username configuration
    # Change this to match your macOS username
    username = "jkmutai";
    userHome = "/Users/${username}";

    # ============================================================================
    # Shared configuration module
    # ============================================================================
    configuration = { pkgs, ... }: {
      # Import modular configuration files
      # Using self to reference files from the flake root
      imports = [
        (self + "/modules/packages.nix")
        (self + "/modules/homebrew.nix")
        (self + "/modules/system-defaults.nix")
        (self + "/modules/nix.nix")
      ];

      # IMPORTANT: Set primary user for system defaults
      system.primaryUser = username;

      # Enable touch ID for sudo
      security.pam.services.sudo_local.touchIdAuth = true;

      # Fonts
      fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        nerd-fonts.meslo-lg
      ];
      # font style set in cursor: Open Settings (Cmd+,), features-terminal, settings.json, 
      # add "terminal.integrated.fontFamily": "'MesloLGS Nerd Font'",

      # The platform
      nixpkgs = {
        hostPlatform = "aarch64-darwin";  # Change to x86_64-darwin for Intel
        config = {
          allowUnfree = true;  # Allow proprietary software
        };
      };

      # User configuration
      users.users.${username} = {
        name = username;
        home = userHome;
        shell = pkgs.zsh;
      };

      # Create screenshots directory
      system.activationScripts.extraActivation.text = ''
        mkdir -p ~/Pictures/Screenshots
      '';
    };

    # Helper function to create darwin system configuration
    # This allows us to easily add configurations for multiple hostnames
    mkDarwinSystem = hostname: nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration 
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import (self + "/home.nix");
          home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
        }
      ];
    };
  in
  {
    # Generate darwin configurations for all hostnames
    # darwin-rebuild automatically detects and uses the correct hostname
    # Usage: darwin-rebuild switch --flake .
    darwinConfigurations = builtins.listToAttrs
      (map (hostname: {
        name = hostname;
        value = mkDarwinSystem hostname;
      }) hostnames);

    # Expose the package set for the first hostname (for convenience)
    # If you have multiple machines, you may want to adjust this
    darwinPackages = self.darwinConfigurations.${builtins.elemAt hostnames 0}.pkgs;
  };
}
