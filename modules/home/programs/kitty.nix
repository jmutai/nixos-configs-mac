{ ... }: let
  theme = import ../theme.nix;
  c = theme.colors;
in {
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };

    settings = {
      # Shell
      shell = "/run/current-system/sw/bin/zsh";
      editor = "/run/current-system/sw/bin/nvim";
      shell_integration = "enabled";
      scrollback_lines = 50000;

      # Window
      hide_window_decorations = "titlebar-only";
      window_padding_width = 12;
      window_padding_height = 8;
      window_margin_width = 0;
      window_border_width = "0.5pt";
      placement_strategy = "center";
      confirm_os_window_close = 0;

      # Cursor
      cursor_shape = "block";
      cursor_blink_interval = 0;

      # Tabs — powerline style
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_min_tabs = 1;
      tab_title_template = "{index}: {title}";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";
      bell_on_tab = false;

      # macOS
      macos_option_as_alt = true;
      macos_colorspace = "displayp3";
      macos_titlebar_color = "background";

      # Input
      paste_actions = "quote-urls-at-prompt,confirm-if-large";
      copy_on_select = "clipboard";
      allow_remote_control = true;

      # Edo theme
      foreground = c.text;
      background = c.base;
      selection_foreground = c.text;
      selection_background = c.surface2;
      cursor = c.rosewater;
      cursor_text_color = c.crust;
      url_color = c.rosewater;
      url_style = "straight";

      # Split/window borders
      active_border_color = c.green;
      inactive_border_color = c.surface2;
      bell_border_color = c.yellow;

      # Tab colors
      active_tab_foreground = c.base;
      active_tab_background = c.green;
      inactive_tab_foreground = c.subtext1;
      inactive_tab_background = c.surface1;
      tab_bar_background = c.mantle;

      # Transparency
      background_opacity = "0.92";
      background_blur = 20;
      dynamic_background_opacity = "yes";

      # ANSI colors
      color0 = c.surface1;
      color1 = c.red;
      color2 = c.green;
      color3 = c.yellow;
      color4 = c.blue;
      color5 = c.pink;
      color6 = c.teal;
      color7 = c.subtext1;
      color8 = c.surface2;
      color9 = c.red;
      color10 = c.green;
      color11 = c.yellow;
      color12 = c.blue;
      color13 = c.pink;
      color14 = c.teal;
      color15 = c.subtext0;
    };

    keybindings = {
      # Splits — same muscle memory as Ghostty
      "cmd+d" = "launch --location=vsplit --cwd=current";
      "cmd+shift+d" = "launch --location=hsplit --cwd=current";

      # Navigate splits
      "cmd+alt+left" = "neighboring_window left";
      "cmd+alt+right" = "neighboring_window right";
      "cmd+alt+up" = "neighboring_window up";
      "cmd+alt+down" = "neighboring_window down";

      # Resize splits
      "cmd+ctrl+left" = "resize_window narrower 3";
      "cmd+ctrl+right" = "resize_window wider 3";
      "cmd+ctrl+up" = "resize_window taller 3";
      "cmd+ctrl+down" = "resize_window shorter 3";

      # Tabs
      "cmd+1" = "goto_tab 1";
      "cmd+2" = "goto_tab 2";
      "cmd+3" = "goto_tab 3";
      "cmd+4" = "goto_tab 4";
      "cmd+5" = "goto_tab 5";
      "cmd+6" = "goto_tab 6";
      "cmd+7" = "goto_tab 7";
      "cmd+8" = "goto_tab 8";
      "cmd+9" = "goto_tab 9";

      # Scrollback search with fzf
      "cmd+f" = "launch --type=overlay --stdin-source=@screen_scrollback /bin/sh -c '/run/current-system/sw/bin/fzf --no-sort --no-mouse --exact -i --tac | tr -d \"\\n\" | kitty +kitten clipboard'";

      # Scrollback in nvim
      "cmd+shift+f" = "launch --stdin-source=@screen_scrollback --stdin-add-formatting --copy-colors --type=overlay /run/current-system/sw/bin/nvim -R -";

      # Clear screen
      "cmd+k" = "clear_terminal to_cursor active";
    };

    extraConfig = ''
      # Font tuning
      modify_font cell_height 115%
      modify_font underline_thickness 50%
      modify_font underline_position 0

      # Bells off
      enable_audio_bell no
      visual_bell_duration 0.0

      # Window size
      remember_window_size yes
      initial_window_width 1200
      initial_window_height 800

      # Splits layout
      enabled_layouts splits,stack
    '';
  };
}
