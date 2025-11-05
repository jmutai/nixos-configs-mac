{ config, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # Basic options
    opts = {
      number = true;
      relativenumber = false;
      expandtab = true;
      tabstop = 2;
      shiftwidth = 2;
      smartindent = true;
      mouse = "a";
      clipboard = "unnamed";
      ignorecase = true;
      smartcase = true;
      termguicolors = true;
      #selectmode = "mouse,key";
      #mousemodel = "popup";
    };
    
    # Color scheme
    #colorschemes.tokyonight.enable = true;
    colorschemes.catppuccin.enable = true;
    
    # Plugins
    plugins = {
      lualine.enable = true;
      nvim-tree.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
      web-devicons.enable = true;
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          lua_ls.enable = true;
        };
      };
    };
  };
}
