{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "jmutai";
        email = "josphatkmutai@gmail.com";
        signingkey = "~/.ssh/id_rsa.pub";
      };

      gpg.format = "ssh";

      commit.gpgsign = true;
      tag.gpgSign = true;

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
        hooksPath = "~/.config/git/hooks";
      };
    };
  };
}

