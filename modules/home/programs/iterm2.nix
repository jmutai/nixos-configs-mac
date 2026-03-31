{ ... }: let
  theme = import ../theme.nix;
  c = theme.colors;
in {
  # iTerm2 Dynamic Profile - automatically loaded from DynamicProfiles directory
  # The Edo theme profile will appear in iTerm2 > Preferences > Profiles
  home.file."Library/Application Support/iTerm2/DynamicProfiles/edo-profile.json".text = builtins.toJSON {
    Profiles = [
      {
        Name = "Edo";
        Guid = "edo-theme-nixos-managed";
        "Dynamic Profile Parent Name" = "Default";
        Default = true;

        # Font
        "Normal Font" = "JetBrainsMonoNFM-Regular 13";
        "Non Ascii Font" = "JetBrainsMonoNFM-Regular 13";
        "Use Non-ASCII Font" = false;
        "ASCII Ligatures" = false;
        "Horizontal Spacing" = 1.0;
        "Vertical Spacing" = 1.15;

        # Colors - Edo theme
        "Foreground Color" = { "Red Component" = 0.847; "Green Component" = 0.839; "Blue Component" = 0.788; "Color Space" = "sRGB"; };
        "Background Color" = { "Red Component" = 0.071; "Green Component" = 0.071; "Blue Component" = 0.071; "Color Space" = "sRGB"; };
        "Bold Color" = { "Red Component" = 0.847; "Green Component" = 0.839; "Blue Component" = 0.788; "Color Space" = "sRGB"; };
        "Cursor Color" = { "Red Component" = 0.788; "Green Component" = 0.490; "Blue Component" = 0.431; "Color Space" = "sRGB"; };
        "Cursor Text Color" = { "Red Component" = 0.0; "Green Component" = 0.0; "Blue Component" = 0.0; "Color Space" = "sRGB"; };
        "Selection Color" = { "Red Component" = 0.2; "Green Component" = 0.2; "Blue Component" = 0.2; "Color Space" = "sRGB"; };
        "Selected Text Color" = { "Red Component" = 0.847; "Green Component" = 0.839; "Blue Component" = 0.788; "Color Space" = "sRGB"; };
        "Badge Color" = { "Red Component" = 0.408; "Green Component" = 0.447; "Blue Component" = 0.671; "Alpha Component" = 0.5; "Color Space" = "sRGB"; };

        # ANSI colors (0-15)
        # Black (surface1)
        "Ansi 0 Color" = { "Red Component" = 0.137; "Green Component" = 0.137; "Blue Component" = 0.137; "Color Space" = "sRGB"; };
        # Red
        "Ansi 1 Color" = { "Red Component" = 0.796; "Green Component" = 0.463; "Blue Component" = 0.463; "Color Space" = "sRGB"; };
        # Green
        "Ansi 2 Color" = { "Red Component" = 0.502; "Green Component" = 0.651; "Blue Component" = 0.396; "Color Space" = "sRGB"; };
        # Yellow
        "Ansi 3 Color" = { "Red Component" = 0.800; "Green Component" = 0.608; "Blue Component" = 0.439; "Color Space" = "sRGB"; };
        # Blue
        "Ansi 4 Color" = { "Red Component" = 0.408; "Green Component" = 0.494; "Blue Component" = 0.667; "Color Space" = "sRGB"; };
        # Magenta (pink)
        "Ansi 5 Color" = { "Red Component" = 0.737; "Green Component" = 0.463; "Blue Component" = 0.757; "Color Space" = "sRGB"; };
        # Cyan (teal)
        "Ansi 6 Color" = { "Red Component" = 0.369; "Green Component" = 0.663; "Blue Component" = 0.580; "Color Space" = "sRGB"; };
        # White (subtext1)
        "Ansi 7 Color" = { "Red Component" = 0.698; "Green Component" = 0.690; "Blue Component" = 0.651; "Color Space" = "sRGB"; };

        # Bright variants
        # Bright Black (surface2)
        "Ansi 8 Color" = { "Red Component" = 0.2; "Green Component" = 0.2; "Blue Component" = 0.2; "Color Space" = "sRGB"; };
        # Bright Red
        "Ansi 9 Color" = { "Red Component" = 0.796; "Green Component" = 0.463; "Blue Component" = 0.463; "Color Space" = "sRGB"; };
        # Bright Green
        "Ansi 10 Color" = { "Red Component" = 0.502; "Green Component" = 0.651; "Blue Component" = 0.396; "Color Space" = "sRGB"; };
        # Bright Yellow
        "Ansi 11 Color" = { "Red Component" = 0.800; "Green Component" = 0.608; "Blue Component" = 0.439; "Color Space" = "sRGB"; };
        # Bright Blue
        "Ansi 12 Color" = { "Red Component" = 0.408; "Green Component" = 0.494; "Blue Component" = 0.667; "Color Space" = "sRGB"; };
        # Bright Magenta
        "Ansi 13 Color" = { "Red Component" = 0.737; "Green Component" = 0.463; "Blue Component" = 0.757; "Color Space" = "sRGB"; };
        # Bright Cyan
        "Ansi 14 Color" = { "Red Component" = 0.369; "Green Component" = 0.663; "Blue Component" = 0.580; "Color Space" = "sRGB"; };
        # Bright White (subtext0)
        "Ansi 15 Color" = { "Red Component" = 0.600; "Green Component" = 0.596; "Blue Component" = 0.584; "Color Space" = "sRGB"; };

        # Link color
        "Link Color" = { "Red Component" = 0.788; "Green Component" = 0.490; "Blue Component" = 0.431; "Color Space" = "sRGB"; };

        # Window appearance
        "Transparency" = 0.08;
        "Blur" = true;
        "Blur Radius" = 30;
        "Columns" = 140;
        "Rows" = 40;
        "Window Type" = 0;

        # Cursor
        "Cursor Type" = 2; # 0=underline, 1=vertical bar, 2=block
        "Blinking Cursor" = false;

        # Scrollback
        "Scrollback Lines" = 100000;
        "Unlimited Scrollback" = false;

        # Terminal behavior
        "Character Encoding" = 4; # UTF-8
        "Terminal Type" = "xterm-256color";
        "Mouse Reporting" = true;
        "Option Key Sends" = 2; # Esc+ (option as meta)
        "Right Option Key Sends" = 2;
        "Shell Integration" = "YES";

        # Padding
        "Top Margin" = 8;
        "Bottom Margin" = 8;
        "Left Margin" = 12;
        "Right Margin" = 12;

        # Bell
        "Silence Bell" = true;
        "Visual Bell" = false;
        "Flashing Bell" = false;

        # Appearance
        "ASCII Anti Aliased" = true;
        "Non-ASCII Anti Aliased" = true;
        "Minimum Contrast" = 0.0;
        "Use Bold Font" = true;
        "Use Bright Bold" = true;
        "Draw Powerline Glyphs" = true;
        "Use Built-in Powerline Glyphs" = true;

        # Title
        "Custom Window Title" = "Edo Terminal";
        "Use Custom Window Title" = false;

        # Status bar
        "Show Status Bar" = true;
        "Status Bar Layout" = {
          "advanced configuration" = {
            "font" = "JetBrainsMonoNFM-Regular 11";
          };
          "algorithm" = 0;
          "components" = [
            {
              "class" = "iTermStatusBarWorkingDirectoryComponent";
              "configuration" = {
                "knobs" = {
                  "path" = "reWrittenPath";
                  "base: compression resistance" = 48;
                  "base: priority" = 5;
                };
              };
            }
            {
              "class" = "iTermStatusBarGitComponent";
              "configuration" = {
                "knobs" = {
                  "base: compression resistance" = 48;
                  "base: priority" = 5;
                };
              };
            }
            {
              "class" = "iTermStatusBarCPUUtilizationComponent";
              "configuration" = {
                "knobs" = {
                  "base: compression resistance" = 48;
                  "base: priority" = 3;
                };
              };
            }
            {
              "class" = "iTermStatusBarMemoryUtilizationComponent";
              "configuration" = {
                "knobs" = {
                  "base: compression resistance" = 48;
                  "base: priority" = 3;
                };
              };
            }
          ];
        };
      }
    ];
  };

}
