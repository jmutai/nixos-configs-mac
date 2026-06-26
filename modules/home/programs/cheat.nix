{ config, ... }:

# cheat (github.com/cheat/cheat) has no home-manager module, so write conf.yml
# directly. The cheatpath is ~/.cheats/sheets — a dedicated dir holding only the
# sheet files; ~/.cheats itself is a catch-all git repo (dotfiles, project backups,
# the c4geeks blog) and cheat recurses with no exclude option, so pointing it at the
# repo root crashes on backup dirs / broken symlinks. CHEAT_CONFIG_PATH pins the
# config location so lookup doesn't depend on per-OS defaults. The `cheat` package
# itself is installed via modules/packages.nix.
let
  cheatsDir = "${config.home.homeDirectory}/.cheats/sheets";
  confPath  = "${config.xdg.configHome}/cheat/conf.yml";
in
{
  xdg.configFile."cheat/conf.yml".text = ''
    editor: nvim

    colorize: true
    style: monokai
    formatter: terminal16m

    pager: less -FRX

    cheatpaths:
      - name: personal
        path: ${cheatsDir}
        tags: [ personal ]
        readonly: false
  '';

  home.sessionVariables.CHEAT_CONFIG_PATH = confPath;
}
