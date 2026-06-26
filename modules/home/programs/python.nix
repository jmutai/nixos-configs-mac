{ config, pkgs, ... }:

{
  # Python packages configuration
  #
  # There are several ways to install Python packages in NixOS/Home Manager:
  #
  # METHOD 1: Packages available in nixpkgs (RECOMMENDED - most reproducible)
  #   - Check if package exists: nix search nixpkgs python3Packages.reportlab
  #   - Add to the list below if available
  #
  # METHOD 2: Packages NOT in nixpkgs
  #   - Use pip directly: python3 -m pip install reportlab --user
  #   - Or use pipx for isolated apps: pipx install reportlab
  #   - Or create a custom package (advanced)
  #
  # METHOD 3: Project-specific packages
  #   - Use direnv with shell.nix or .envrc (you already have direnv installed)
  #   - Create virtual environments per project

  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      # pip  # Uncomment to include pip for manual installations
      reportlab
      numpy
      pandas
      requests
      setuptools
      wheel
    ]))
  ];
}

