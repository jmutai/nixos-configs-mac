{
  # Security settings
  # Enable touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # System settings and optimizations
  system = {
    defaults = {
      menuExtraClock.Show24Hour = true; # show 24 hour clock
      
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
        "com.apple.swipescrolldirection" = true; # enable natural scrolling(default to true)
        "com.apple.sound.beep.feedback" = 0;     # disable beep sound when pressing volume up/down key
        "com.apple.keyboard.fnState" = true;     # fn for f1-12
        AppleInterfaceStyle = "Dark";            # dark mode

        # Keyboard settings
        ApplePressAndHoldEnabled = false;        # Enable key repeat
        InitialKeyRepeat = 15;                   # Fast key repeat
        KeyRepeat = 2;                           # Very fast key repeat
        
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

  # Keyboard remapping: ±§ → `~
  # Using hidutil to remap keys via launch agent (persists across reboots)
  # Note: Keycode 0x64 is ±§ key, 0x35 is grave/tilde key
  # To find your keycodes, run: hidutil property --matching '{"ProductID":0x...}'
  # Alternative: Use Karabiner Elements (already in homebrew casks) for GUI-based remapping
  system.activationScripts.keyboardRemap = ''
    # Create launch agent to persist keyboard remapping
    mkdir -p ~/Library/LaunchAgents
    cat > ~/Library/LaunchAgents/com.user.keyboard-remap.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.user.keyboard-remap</string>
  <key>ProgramArguments</key>
  <array>
    <string>/usr/bin/hidutil</string>
    <string>property</string>
    <string>--set</string>
    <string>{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x64,"HIDKeyboardModifierMappingDst":0x35}]}</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
EOF
    # Load the launch agent (unload first if exists to avoid duplicates)
    launchctl unload ~/Library/LaunchAgents/com.user.keyboard-remap.plist 2>/dev/null || true
    launchctl load ~/Library/LaunchAgents/com.user.keyboard-remap.plist 2>/dev/null || true
    # Apply immediately
    /usr/bin/hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x64,"HIDKeyboardModifierMappingDst":0x35}]}' 2>/dev/null || true
  '';
}

