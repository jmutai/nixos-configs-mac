{ config, pkgs, ... }:

{
  programs.clock-rs = {
    enable = true;
    settings = {
      date = {
        fmt = "%H:%M:%S";  # 24-hour format (H = 24h, h = 12h)
        use_12h = false;
        hide_seconds = false;
      };
    };
  };

  # Override config file directly to ensure 24-hour format
  # The fmt should be in [date] section, not [general]
  home.file."Library/Application Support/clock-rs/conf.toml" = {
    force = true;
    text = ''
[date]
fmt = "%H:%M:%S"
use_12h = false
hide_seconds = false
'';
  };
}

