{ ... }:

{
  programs.clock-rs = {
    enable = true;
    settings = {
      date = {
        use_12h = false;
        hide_seconds = false;
      };
    };
  };
}

