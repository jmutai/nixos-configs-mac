{
  description = "My nix-darwin system configuration";

  ##################################################################################################################
  #
  # Want to learn more about Nix in detail? Check out the following resources:
  #   - https://zero-to-nix.com/
  #   - https://nixos-and-flakes.thiscute.world/
  #   - https://github.com/nix-community/awesome-nix
  #
  ##################################################################################################################

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    pwaerospace.url = "path:./modules/home/programs/aerospace";
    sketchybar-config.url = "path:./modules/home/programs/sketchybar";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, agenix, nixvim, pwaerospace, sketchybar-config }:
  let
    # ============================================================================
    # Configuration Variables - Edit these to customize your setup
    # ============================================================================
    
    # List of hostnames to generate configurations for
    # Add your hostnames here - darwin-rebuild will automatically use the correct one
    # You can check your hostname with: hostname
    hostnames = [
      "macbook-pro-3"  # Current hostname: scutil --get HostName 
      # Add more hostnames here as needed, e.g.:
      # "My-MacBook-Air"
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
        (self + "/modules/system-settings.nix")
        (self + "/modules/nix-core.nix")
      ];

      # IMPORTANT: Set primary user for system defaults
      system.primaryUser = username;

      # The platform
      nixpkgs = {
        hostPlatform = "aarch64-darwin";  # Change to x86_64-darwin for Intel
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
          networking.hostName = hostname;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit pwaerospace sketchybar-config;
          };
          home-manager.users.${username} = import (self + "/home.nix");
          home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
        }
      ];
      specialArgs = {
        inherit pwaerospace sketchybar-config;
      };
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
