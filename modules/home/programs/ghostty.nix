{ ... }: let
  theme = import ../theme.nix;
  c = theme.colors;
  strip = theme.rawHexValue;
in {
  xdg.configFile."ghostty/config".text = ''
    # Shell
    command = /run/current-system/sw/bin/zsh
    shell-integration = zsh
    shell-integration-features = cursor,sudo,title

    # Font — matching Tabby's setup
    font-family = JetBrainsMono Nerd Font
    font-size = 14
    font-thicken = true
    adjust-cell-height = 15%

    # Window
    window-padding-x = 12
    window-padding-y = 8
    window-save-state = always
    window-inherit-working-directory = true
    confirm-close-surface = false
    macos-titlebar-style = tabs
    macos-option-as-alt = true
    macos-window-shadow = true

    # Cursor
    cursor-style = block
    cursor-style-blink = true

    # Scrollback
    scrollback-limit = 50000

    # Mouse
    copy-on-select = clipboard
    mouse-scroll-multiplier = 2

    # Edo theme colors — matching Tabby
    background = ${strip c.base}
    foreground = ${strip c.text}
    cursor-color = ${strip c.rosewater}
    cursor-text = ${strip c.crust}
    selection-background = ${strip c.surface2}
    selection-foreground = ${strip c.text}

    # Normal colors
    palette = 0=${strip c.surface1}
    palette = 1=${strip c.red}
    palette = 2=${strip c.green}
    palette = 3=${strip c.yellow}
    palette = 4=${strip c.blue}
    palette = 5=${strip c.pink}
    palette = 6=${strip c.teal}
    palette = 7=${strip c.subtext1}

    # Bright colors
    palette = 8=${strip c.surface2}
    palette = 9=${strip c.red}
    palette = 10=${strip c.green}
    palette = 11=${strip c.yellow}
    palette = 12=${strip c.blue}
    palette = 13=${strip c.pink}
    palette = 14=${strip c.teal}
    palette = 15=${strip c.subtext0}

    # Visual effects
    background-opacity = 0.92
    background-blur-radius = 20
    minimum-contrast = 1.1

    # Keybindings
    keybind = cmd+d=new_split:right
    keybind = cmd+shift+d=new_split:down
    keybind = cmd+shift+enter=toggle_split_zoom
    keybind = cmd+opt+left=goto_split:left
    keybind = cmd+opt+right=goto_split:right
    keybind = cmd+opt+up=goto_split:top
    keybind = cmd+opt+down=goto_split:bottom
    keybind = cmd+shift+equal=equalize_splits
    keybind = cmd+k=clear_screen
    keybind = cmd+enter=toggle_fullscreen
  '';
}
