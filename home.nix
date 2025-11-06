{ config, pkgs, ... }:

{
  imports = [
    ./nixvim.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should manage
  home.stateVersion = "25.05";

  # Packages specific to your user
  home.packages = with pkgs; [
    nnn
    zsh-completions

    # Microservices
    kubectl

    # Infrastructure as Code
    ansible
    opentofu
    terragrunt

    # Container tools
    podman
    podman-compose
    k9s
    lens

    # Cloud CLI tools
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])

    # Database clients
    postgresql
    mariadb

    # VPN clients
    openvpn    # OpenVPN CLI
    tailscale  # Tailscale CLI
    netbird    # NetBird CLI
  ];

  # Oh My Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Powerlevel10k theme
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
    ];
    
    oh-my-zsh = {
      enable = true;
      #theme = "robbyrussell";
      plugins = [
        "git"
        "docker"
        "kubectl"
        "terraform"
        "macos"
        "colored-man-pages"
        "opentofu"
        "ansible"
        "argocd"
        "gcloud"
        "fzf"
        "kubectx"
        "sudo"
      ];
    };

    # Shell aliases - imported from modules/aliases.nix
    shellAliases = import ./modules/aliases.nix;

    # Additional zsh configuration
    initContent = ''
      # Add zsh-completions to fpath FIRST, before anything else
      fpath+=${pkgs.zsh-completions}/share/zsh/site-functions

      # Powerlevel10k configuration
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      
      # Source Powerlevel10k theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      
      # Load p10k config if it exists, will exist after prompt
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      # Custom prompt or other configurations
      export EDITOR="nvim"
      export VISUAL="nvim"

       # Krew (kubectl plugin manager)
       # First run: setup_krew && install_krew_plugins functions 
       export PATH="''${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
      
      # fzf configuration
      export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      
      # Homebrew
      eval "$(/opt/homebrew/bin/brew shellenv)"

      # Source custom functions from ~/.cheats/functions.sh
      if [ -f ~/.cheats/functions.sh ]; then
        source ~/.cheats/functions.sh
      fi

      # Completion styling
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
  '';
  };

  # Add Starship prompt
#  programs.starship = {
#    enable = true;
#    enableZshIntegration = true;
#    settings = {
#      add_newline = true;
#      character = {
#        success_symbol = "[➜](bold green)";
#        error_symbol = "[➜](bold red)";
#      };
#    };
#  };
  # Git configuration
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

  # Bat (better cat) configuration
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      pager = "less -FR";
    };
    themes = {};
    syntaxes = {};
  };

  # fzf configuration
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # tmux configuration (optional but recommended)
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    terminal = "screen-256color";
    
    extraConfig = ''
      # Enable mouse support
      set -g mouse on
      
      # Start windows and panes at 1, not 0
      set -g base-index 1
      setw -g pane-base-index 1
      
      # Renumber windows when one is closed
      set -g renumber-windows on
    '';
  };

  # htop configuration
  programs.htop = {
    enable = true;
    settings = {
      tree_view = true;
      hide_kernel_threads = true;
      hide_userland_threads = true;
    };
  };
  
}
