{
  # Enable touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    defaults = {
      menuExtraClock.Show24Hour = true;
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

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = false;
        ShowPathbar = true;
        ShowStatusBar = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";  # List view
        _FXShowPosixPathInTitle = true;
      };

      loginwindow = {
        autoLoginUser = null;
        GuestEnabled = false;
        DisableConsoleAccess = true;
        LoginwindowText = "Welcome to macOS";
      };

      NSGlobalDomain = {
        "com.apple.swipescrolldirection" = true; # natural scrolling
        "com.apple.sound.beep.feedback" = 0;     # disable beep on volume keys
        "com.apple.keyboard.fnState" = false;    # Use media keys by default
        AppleInterfaceStyle = "Dark";

        ApplePressAndHoldEnabled = false;        # Enable key repeat
        InitialKeyRepeat = 15;
        KeyRepeat = 2;

        AppleShowAllExtensions = true;
        AppleShowAllFiles = false;

        # Disable automatic features
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;

        NSWindowResizeTime = 0.001;

        # Expand save and print panels by default
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
      };

      trackpad = {
        Clicking = true;  # Tap to click
        TrackpadThreeFingerDrag = true;
      };

      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 0;
      };

      screencapture = {
        location = "~/Pictures/Screenshots";
        type = "png";
        disable-shadow = true;
      };

      CustomUserPreferences = {
        # Disable Apple personalized advertising
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };

        # Speed up Mission Control animations
        "com.apple.dock" = {
          expose-animation-duration = 0.1;
        };

        # 24-hour clock in menu bar
        "com.apple.menuextra.clock" = {
          Show24Hour = true;
          ShowAMPM = false;
        };

        # Require password immediately after sleep or screen saver begins
        "com.apple.screensaver" = {
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    stateVersion = 6;

  };
}
