{ ... }: let
  theme = import ../theme.nix;
  c = theme.colors;
  strip = theme.rawHexValue;
in {
  # Ghostty isn't packaged for macOS in nixpkgs yet; just manage the config file.
  xdg.configFile."ghostty/config".text = ''
    # Basic behavior
    shell-integration = detect
    scrollback-limit = 100000
    window-inherit-working-directory = true
    command = /run/current-system/sw/bin/zsh

    # Font Settings - Nerd Fonts for CLI
    font-family = "JetBrainsMono Nerd Font", "FiraCode Nerd Font", "MesloLGS Nerd Font", "Hack Nerd Font", "SF Mono", Monaco, monospace
    font-size = 12
    font-thicken = true
    font-feature = -calt,-liga,-dlig
    adjust-cell-height = 50%
    adjust-underline-thickness = 50%
    adjust-underline-position = 0

    # Window Appearance
    window-padding-x = 12
    window-padding-y = 8

    # Cursor Settings
    cursor-style = block

    # macOS specific
    macos-option-as-alt = true
    macos-icon = holographic
    macos-titlebar-style = hidden

    # Colors (Edo theme)
    foreground = ${strip c.text}
    background = ${strip c.base}
    selection-foreground = ${strip c.text}
    selection-background = ${strip c.surface2}
    cursor-color = ${strip c.rosewater}
    cursor-text = ${strip c.crust}

    # ANSI Color Palette
    palette = 0=${strip c.surface1}
    palette = 1=${strip c.red}
    palette = 2=${strip c.green}
    palette = 3=${strip c.yellow}
    palette = 4=${strip c.blue}
    palette = 5=${strip c.pink}
    palette = 6=${strip c.teal}
    palette = 7=${strip c.subtext1}
    palette = 8=${strip c.surface2}
    palette = 9=${strip c.red}
    palette = 10=${strip c.green}
    palette = 11=${strip c.yellow}
    palette = 12=${strip c.blue}
    palette = 13=${strip c.pink}
    palette = 14=${strip c.teal}
    palette = 15=${strip c.subtext0}

    # Transparency & Visual Effects
    background-opacity = 0.92
    background-blur-radius = 30
    alpha-blending = native
    window-colorspace = display-p3

    # Window Title
    window-title-font-family = "JetBrainsMono Nerd Font", "SF Mono", Monaco

    # Input & Keyboard
    copy-on-select = true
  '';
}
