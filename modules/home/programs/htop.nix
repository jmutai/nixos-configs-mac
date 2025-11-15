{ ... }:

{
  programs.htop = {
    enable = true;
    settings = {
      tree_view = true;
      hide_kernel_threads = true;
      hide_userland_threads = true;
    };
  };
}

