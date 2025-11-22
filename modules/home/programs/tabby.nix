{ ... }: let
  theme = import ../theme.nix;
  c = theme.colors;
  strip = theme.rawHexValue;
in {
  # Manage Tabby terminal configuration
  # Tabby stores configs in ~/Library/Application Support/Tabby/config.yaml
  # Since this is macOS-specific, we use home.file instead of xdg.configFile

  home.file."Library/Application Support/Tabby/config.yaml" = {
    force = true;
    text = ''
version: 7
profiles: []
groups: []
configSync:
  parts: {}
hotkeys:
  toggle-window:
    - Ctrl-Space
terminal:
  searchOptions: {}
  colorScheme:
    name: Edo Theme
    foreground: ${strip c.text}
    background: ${strip c.base}
    cursor: ${strip c.rosewater}
    colors:
      - ${strip c.surface1}
      - ${strip c.red}
      - ${strip c.green}
      - ${strip c.yellow}
      - ${strip c.blue}
      - ${strip c.pink}
      - ${strip c.teal}
      - ${strip c.subtext1}
      - ${strip c.surface2}
      - ${strip c.red}
      - ${strip c.green}
      - ${strip c.yellow}
      - ${strip c.blue}
      - ${strip c.pink}
      - ${strip c.teal}
      - ${strip c.subtext0}
  font:
    size: 12
    family: "JetBrainsMono Nerd Font", "FiraCode Nerd Font", "MesloLGS Nerd Font", "Hack Nerd Font", "SF Mono", Monaco, monospace
  backgroundOpacity: 0.92
  ligatures: true
  cursorBlink: true
  cursorWidth: 2
  linePadding: 0
  bell: none
  rightClick: paste
  copyOnSelect: true
  scrollbackLines: 10000
ssh: {}
clickableLinks:
  enabled: true
  modifiers: cmd
accessibility:
  reduceMotion: false
appearance:
  theme: dark
  opacity: 0.92
  frame: native
  vibrancy: true
hacks:
  macosOptionIsMeta: true
providerBlacklist: []
commandBlacklist: []
enableWelcomeTab: false
'';
  };
}

