{...}: let
  theme = import ../theme.nix;
  c = theme.colors;
in {
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };

    settings = {
      url_style = "straight";

      shell_integration = "enabled";
      scrollback_lines = 10000;

      inactive_tab_font_style = "normal";
      active_tab_font_style = "bold";

      tab_bar_edge = "bottom";
      tab_bar_align = "left";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_min_tabs = 1;
      tab_activity_symbol = "none";
      bell_on_tab = false;

      tab_title_template = "{title}";

      window_padding_width = 15;
      window_padding_height = 15;
      window_margin_width = 0;

      hide_window_decorations = "titlebar-only";
      window_border_width = 0;

      cursor_shape = "block";
      cursor_blink_interval = 0.5;

      editor = "/run/current-system/sw/bin/nvim";
      shell = "/run/current-system/sw/bin/zsh";

      macos_option_as_alt = true;
      macos_colorspace = "displayp3";

      paste_actions = "quote-urls-at-prompt,confirm-if-large";

      allow_remote_control = true;

      # edo theme colors
      foreground = c.text;
      background = c.mantle;
      selection_foreground = "none";
      selection_background = c.surface2;

      cursor = c.rosewater;
      cursor_text_color = c.crust;

      url_color = c.rosewater;

      active_border_color = c.lavender;
      inactive_border_color = c.overlay1;
      bell_border_color = c.yellow;

      wayland_titlebar_color = "system";
      macos_titlebar_color = "system";

      active_tab_foreground = c.text;
      active_tab_background = c.surface1;
      inactive_tab_foreground = c.subtext1;
      inactive_tab_background = c.base;
      tab_bar_background = c.base;

      background_opacity = "0.92";
      background_blur = 30;
      dynamic_background_opacity = "yes";

      mark1_foreground = c.crust;
      mark1_background = c.lavender;

      mark2_foreground = c.crust;
      mark2_background = c.mauve;

      mark3_foreground = c.crust;
      mark3_background = c.sky;

      # Terminal colors
      color0 = c.surface1;
      color8 = c.surface2;

      color1 = c.red;
      color9 = c.red;

      color2 = c.green;
      color10 = c.green;

      color3 = c.yellow;
      color11 = c.yellow;

      color4 = c.blue;
      color12 = c.blue;

      color5 = c.pink;
      color13 = c.pink;

      color6 = c.teal;
      color14 = c.teal;

      color7 = c.subtext1;
      color15 = c.subtext0;

      disable_ligatures = "never";
    };

    keybindings = {
      "cmd+click" = "open_url";
      "cmd+1" = "goto_tab 1";
      "cmd+2" = "goto_tab 2";
      "cmd+3" = "goto_tab 3";
      "cmd+4" = "goto_tab 4";
      "cmd+5" = "goto_tab 5";
      "cmd+6" = "goto_tab 6";
      "cmd+7" = "goto_tab 7";
      "cmd+8" = "goto_tab 8";
      "cmd+9" = "goto_tab 9";
      "cmd+f" = "launch --type=overlay --stdin-source=@screen_scrollback /bin/sh -c '/run/current-system/sw/bin/fzf --no-sort --no-mouse --exact -i --tac | tr -d \"\\n\" | kitty +kitten clipboard'";
      "alt+f" = "launch --stdin-source=@screen_scrollback --stdin-add-formatting --copy-colors --type=tab --title=\"scrollback search\" /run/current-system/sw/bin/nvim";
    };

    extraConfig = ''
      # Font adjustments - match Ghostty settings
      modify_font underline_thickness 50%
      modify_font underline_position 0
      modify_font cell_height 110%

      # Disable bells
      enable_audio_bell no
      visual_bell_duration 0.0

      # Mouse support
      mouse_map cmd+click open_url
      copy_on_select yes
      strip_trailing_spaces never

      # Window appearance
      remember_window_size yes
      initial_window_width 1200
      initial_window_height 800
    '';
  };
}
