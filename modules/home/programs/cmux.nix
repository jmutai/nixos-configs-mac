{ ... }: let
  theme = import ../theme.nix;
  c = theme.colors;
in {
  # cmux settings — cmux inherits terminal rendering from ghostty config
  xdg.configFile."cmux/settings.json".text = builtins.toJSON {
    # Notifications — key feature for agent workflows
    notifications = {
      enabled = true;
      sound = false;          # visual only, no audio spam
      showInDock = true;      # badge dock icon on agent activity
    };

    # Sidebar metadata
    sidebar = {
      showGitBranch = true;
      showWorkingDirectory = true;
      showListeningPorts = true;
      showPrStatus = true;
    };

    # Browser pane settings
    browser = {
      importCookiesFrom = "brave-browser";  # match your primary browser
    };

    # Appearance — complement ghostty/edo theme
    appearance = {
      tabBarPosition = "left";
      showTabBar = true;
    };
  };
}
