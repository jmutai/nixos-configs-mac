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
    google-cloud-sdk

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

    # Shell aliases
    shellAliases = {
      # Modern replacements
      ls  = "eza --icons=always";
      ll  = "eza -l --icons=always";
      la  = "eza -la --icons=always";
      cat = "bat --plain";
      
      # Git shortcuts
      g  = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";

      # kubectl aliases 
      k     = "kubectl";
      kg    = "kubectl get";
      kn    = "kubectl-ns";
      kns   = "kubectl node-shell";
      kgns  = "kubectl get ns";
      kgp   = "kubectl get pods";
      kgd   = "kubectl get deploy";
      kdd   = "kubectl describe deploy";
      kga   = "kubectl get applications -n argocd";
      kgas  = "kubectl get applicationset -n argocd";
      kgsts = "kubectl get sts";
      kda   = "kubectl describe apps -n argocd";
      kdas  = "kubectl describe appset -n argocd";
      kgpa  = "kubectl get pods --all-namespaces";
      kd    = "kubectl describe";
      kdp   = "kubectl describe pod";
      kl    = "kubectl logs";
      kdelp = "kubectl delete pod";
      kaf   = "kubectl apply -f";
      kdf   = "kubectl delete -f";
      kgs   = "kubectl get services";
      kgsec = "kubectl get secrets";
      kgn   = "kubectl get nodes";
      kexec = "kubectl exec -it";
      kge   = "kubectl get events";
      kgj   = "kubectl get jobs";
      kgcj  = "kubectl get cronjobs";
      kvs   = "kubectl view-secret";
      ktn   = "kubectl top nodes";
      ktp   = "kubectl top pods";
      ## Crossplane
      kgc   = "kubectl get composition";
      kdci  = "kubectl delete composition";
      kgx   = "kubectl get xrd";
      kdx   = "kubectl delete xrd";
      kgo   = "kubectl get objects";
      kdo   = "kubectl delete objects";
      kgm   = "kubectl get managed";
      kgxp  = "kubectl get providers";
      kgxpv = "kubectl get pkgrev";

      # Utilities
      h     = "htop";

      # Terraform/OpenTofu shortcuts
      tg    = "terragrunt";
      tf    = "tofu";
      tfa   = "tofu apply";
      tfp   = "tofu plan";
      tfi   = "tofu init";
      tgp   = "terragrunt plan";
      tga   = "terragrunt apply";
      tgaa  = "terragrunt apply -auto-approve";
      tra   = "terragrunt run --all apply";
      traa  = "terragrunt run --all --non-interactive apply";
      trp   = "terragrunt run --all plan";

      # Docker/Podman aliases
      d      = "docker";
      dc     = "docker-compose";
      dps    = "docker ps";
      dpsa   = "docker ps -a";
      di     = "docker images";
      dex    = "docker exec -it";
      dlogs  = "docker logs";
      dstop  = "docker stop";
      drm    = "docker rm";
      drmi   = "docker rmi";
      dprune = "docker system prune -af";

      # Podman aliases
      p      = "podman";
      pc     = "podman-compose";
      pps    = "podman ps";
      ppsa   = "podman ps -a";
      pi     = "podman images";
      pex    = "podman exec -it";
      plogs  = "podman logs";
      pstop  = "podman stop";
      prm    = "podman rm";
      prmi   = "podman rmi";
      pprune = "podman system prune -af";
      
      # System
      #update  = "cd /etc/nix-darwin && sudo nix run nix-darwin/master#darwin-rebuild -- switch";
      update = ''cd ~/Library/"Mobile Documents"/com~apple~CloudDocs/projects/nixos-configs-mac && sudo darwin-rebuild switch --flake .'';
      upgrade = ''cd ~/Library/"Mobile Documents"/com~apple~CloudDocs/projects/nixos-configs-mac && nix flake update && sudo darwin-rebuild switch --flake .'';
      cleanup = "nix-collect-garbage -d";
      
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      
    };

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
  # Git configuration - UPDATED with new option names
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
