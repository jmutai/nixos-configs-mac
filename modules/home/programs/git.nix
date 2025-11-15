{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "jmutai";
        email = "josphatkmutai@gmail.com";
      };

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
        visual = "log --graph --oneline --all";
      };

      init = {
        defaultBranch = "main";
      };

      pull = {
        rebase = false;
      };

      core = {
        editor = "nvim";
      };
    };
  };
}

