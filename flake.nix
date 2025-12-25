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
    antigravity-nix.url = "github:jacopone/antigravity-nix";
    antigravity-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, agenix, nixvim, antigravity-nix }:
  let
    # ============================================================================
    # Configuration Variables - Edit these to customize your setup
    # ============================================================================

    # List of hostnames to generate configurations for
    # Add your hostnames here - darwin-rebuild will automatically use the correct one
    # You can check your hostname with: hostname
    hostnames = [
      "macbook-pro-3"
      "jkm-macbook-pro-4"
      # Current hostname: scutil --get HostName
      # Add more hostnames here as needed
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
        overlays = [
          # Fix terragrunt build issue with vendor directory
          # The vendor directory check fails during generate-mocks in the go-modules build
          (final: prev: {
            terragrunt = prev.terragrunt.overrideAttrs (oldAttrs: {
              env = (oldAttrs.env or {}) // {
                GOWORK = "off";
                GOPROXY = "https://proxy.golang.org,direct";
              };
              # Patch Makefile to skip vendor validation that fails during go-modules build
              # The generate-mocks target at line 48 fails due to vendor directory mismatch
              # We keep vendor mode but skip the strict validation check
              postPatch = (oldAttrs.postPatch or "") + ''
                export GOWORK=off
                if [ -f Makefile ]; then
                  # Make line 48 (the failing vendor check command) not fail
                  # Replace it with a no-op that doesn't check vendor sync
                  sed -i.bak '48s/.*/\techo "Skipping vendor check for Nix build" || true/' Makefile || true
                fi
              '';
              preBuild = (oldAttrs.preBuild or "") + ''
                export GOWORK=off
              '';
            });
          })
          # antigravity-nix.overlays.default
        ];
      };

      # User configuration
      users.users.${username} = {
        name = username;
        home = userHome;
        shell = pkgs.zsh;
      };
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
          home-manager.extraSpecialArgs = { };
          home-manager.users.${username} = import (self + "/home.nix");
          home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
        }
      ];
      specialArgs = { };
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
