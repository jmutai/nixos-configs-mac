{
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
    stateVersion = 6;
  };
}

