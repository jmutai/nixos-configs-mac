{
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      max-jobs = 8;
      cores = 0;  # Use all available cores
    };

    # UPDATED: Use nix.optimise.automatic instead of auto-optimise-store
    optimise.automatic = true;

    gc = {
      automatic = true;
      interval = { Weekday = 7; };  # Run on Sundays
      options = "--delete-older-than 30d";
    };
  };
}

