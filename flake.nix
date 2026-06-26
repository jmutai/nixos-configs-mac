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
    # Core package set — unstable channel for newest packages on macOS
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nix-darwin: declarative macOS system configuration
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # home-manager: declarative per-user dotfiles/program config
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # agenix: age-encrypted secrets management
    agenix.url = "github:ryantm/agenix";
    # nixvim: Neovim configured entirely in Nix
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, agenix, nixvim}:
  let
    # List of hostnames to generate configurations for.
    # darwin-rebuild automatically picks the entry matching the current machine.
    #   - Check your hostname with: scutil --get HostName   (or just: hostname)
    #   - To adopt this config on a new Mac, add that hostname to the list below.
    hostnames = [
      "macbook-pro-3"
      "jkm-macbook-pro-4"
      # Add more hostnames here as needed
    ];

    # Username configuration.
    # CHANGE THIS to match your macOS login name (run `whoami` to find it).
    # It drives users.users.<name>, the home directory path, and the
    # home-manager.users.<name> mapping below — keep all three in sync.
    username = "jkmutai";
    # Home directory derived from the username. On macOS this is always
    # /Users/<username>; no need to edit unless you use a non-standard home.
    userHome = "/Users/${username}";

    # Shared system-level configuration applied to every host.
    configuration = { pkgs, ... }: {
      # System modules — add new system-wide modules to this list.
      imports = [
        (self + "/modules/packages.nix")         # system + user + homebrew packages
        (self + "/modules/system-settings.nix")  # macOS defaults (dock, finder, keyboard)
        (self + "/modules/nix-core.nix")         # nix daemon, gc, store optimization
      ];

      # IMPORTANT: nix-darwin needs to know which user owns system defaults
      # (Touch ID, dock, etc.). Must match `username` above.
      system.primaryUser = username;

      nixpkgs = {
        # Apple Silicon by default. CHANGE to "x86_64-darwin" on Intel Macs.
        hostPlatform = "aarch64-darwin";
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

      # Register the macOS user account. `shell = pkgs.zsh` makes zsh the
      # nix-managed login shell (configured in modules/home/programs/zsh.nix).
      users.users.${username} = {
        name = username;
        home = userHome;
        shell = pkgs.zsh;
      };
    };

    # Builds a complete darwin system for a single hostname by stitching together
    # the shared `configuration` above with home-manager. Called once per host.
    mkDarwinSystem = hostname: nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        home-manager.darwinModules.home-manager
        {
          networking.hostName = hostname;
          # useGlobalPkgs: home-manager reuses the system nixpkgs (no second copy).
          home-manager.useGlobalPkgs = true;
          # useUserPackages: install user packages into /etc/profiles, not ~/.nix-profile.
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { };
          # Per-user config entry point. CHANGE the attr name if you renamed `username`.
          home-manager.users.${username} = import (self + "/home.nix");
          # Make nixvim's home-manager module available to home.nix.
          home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
        }
      ];
      specialArgs = { };
    };
  in
  {
    # Generate one darwinConfiguration per hostname so the same flake works on
    # every Mac. Build with: sudo darwin-rebuild switch --flake .
    darwinConfigurations = builtins.listToAttrs
      (map (hostname: {
        name = hostname;
        value = mkDarwinSystem hostname;
      }) hostnames);

    # Convenience output exposing the resolved package set of the first host
    # (handy for `nix repl` / debugging; not required by darwin-rebuild).
    darwinPackages = self.darwinConfigurations.${builtins.elemAt hostnames 0}.pkgs;
  };
}
