{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;

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
    shellAliases = import ../../aliases.nix;

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
      export PATH="''${KREW_ROOT:-$HOME/.krew}/bin:$HOME/.local/bin:$PATH"

      # fzf configuration
      export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

      # Homebrew
      eval "$(/opt/homebrew/bin/brew shellenv)"

      # Crossplane completions
      if command -v crossplane &> /dev/null; then
        # Try both syntaxes in case the command format varies by version
        source <(crossplane completions 2>/dev/null) || \
        source <(crossplane completions zsh 2>/dev/null) || true
      fi

      # Source custom functions from ~/.cheats/functions.sh
      if [[ -f ~/.cheats/functions.sh ]]; then
        source ~/.cheats/functions.sh
      fi

      # age encrypt/decrypt using an SSH key (default ~/.ssh/id_rsa; override with $AGE_KEY)
      # encrypt: pubkey (id_rsa.pub) as recipient | decrypt: private key (id_rsa) as identity
      age-enc() {
        # usage: age-enc <file> [out]   (default out: <file>.age)
        local key="''${AGE_KEY:-$HOME/.ssh/id_rsa}"
        [[ -n "$1" ]] || { print -u2 "usage: age-enc <file> [out.age]"; return 1; }
        local out="''${2:-$1.age}"
        age -R "$key.pub" -o "$out" "$1" && print "encrypted -> $out"
      }
      age-dec() {
        # usage: age-dec <file.age> [out]   (no out = print to stdout)
        local key="''${AGE_KEY:-$HOME/.ssh/id_rsa}"
        [[ -n "$1" ]] || { print -u2 "usage: age-dec <file.age> [out]"; return 1; }
        if [[ -n "$2" ]]; then
          age -d -i "$key" -o "$2" "$1" && print "decrypted -> $2"
        else
          age -d -i "$key" "$1"
        fi
      }
      age-edit() {
        # usage: age-edit <file.age>   decrypt -> $EDITOR -> re-encrypt, plaintext never hits cwd
        local key="''${AGE_KEY:-$HOME/.ssh/id_rsa}"
        [[ -n "$1" ]] || { print -u2 "usage: age-edit <file.age>"; return 1; }
        [[ -f "$1" ]] || { print -u2 "age-edit: $1 not found"; return 1; }
        local tmp; tmp="$(mktemp "''${TMPDIR:-/tmp}/age-edit.XXXXXX")" || return 1
        chmod 600 "$tmp"
        if ! age -d -i "$key" -o "$tmp" "$1"; then
          rm -f "$tmp"; print -u2 "age-edit: decrypt failed"; return 1
        fi
        "''${EDITOR:-nvim}" "$tmp" \
          && age -R "$key.pub" -o "$1" "$tmp" \
          && print "re-encrypted -> $1"
        rm -f "$tmp"
      }

      # Completion styling
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
    '';
  };
}

