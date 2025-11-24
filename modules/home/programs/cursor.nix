{ config, lib, ... }:

let
  # List of extensions to automatically install
  cursorExtensions = [
    # Language Support
    "ms-python.python"
    "ms-python.vscode-pylance"
    "golang.go"
    "rust-lang.rust-analyzer"

    # Formatting & Linting
    "esbenp.prettier-vscode"
    "dbaeumer.vscode-eslint"
    "ms-python.black-formatter"
    "ms-python.isort"
    "ms-python.flake8"

    # Git
    "eamodio.gitlens"
    "mhutchie.git-graph"

    # UI & Themes
    "pkief.material-icon-theme"
    "zhuangtongfa.material-theme"
    "catppuccin.catppuccin-vsc"

    # Productivity
    "usernamehw.errorlens"
    # "streetsidesoftware.code-spell-checker"  # Removed - unknown word warnings
    # "ms-vscode.vscode-json"  # Built-in, no need to install
    "redhat.vscode-yaml"
    "ms-vscode.hexeditor"

    # Docker & Containers
    "ms-azuretools.vscode-docker"

    # Markdown
    "yzhang.markdown-all-in-one"
    "davidanson.vscode-markdownlint"

    # Terminal
    "formulahendry.auto-rename-tag"
    "christian-kohler.path-intellisense"

    # Nix
    "jnoortheen.nix-ide"

    # Terraform & Terragrunt
    "hashicorp.terraform"  # Official Terraform extension with HCL support
    "4ops.terraform"  # Additional Terraform features
    # "run-at-scale.terragrunt"  # Extension doesn't exist or not available
    "ms-kubernetes-tools.vscode-kubernetes-tools"  # Kubernetes support (useful with Terraform)

    # Utilities
    # "ms-vscode.remote-repositories"  # Not available as separate extension (built into Cursor)
  ];
in
{
  # Manage Cursor IDE configuration files
  # Cursor stores configs in ~/Library/Application Support/Cursor/User/
  # Since this is macOS-specific, we use home.file instead of xdg.configFile

  home.file."Library/Application Support/Cursor/User/settings.json" = {
    force = true;
    text = ''
    {
      // Window settings
      "window.commandCenter": true,
      "workbench.colorTheme": "Cursor Dark Midnight",

      // Editor font settings - Popular IDE fonts (no Nerd Fonts)
      // Most popular: JetBrains Mono, SF Mono (macOS native), Fira Code, Source Code Pro
      "editor.fontFamily": "'SF Mono', 'JetBrains Mono', 'Fira Code', 'Source Code Pro', Monaco, 'Cascadia Code', Menlo, Consolas, monospace",
      "editor.fontSize": 13,
      "editor.fontLigatures": true,
      "editor.fontWeight": "400",
      "editor.lineHeight": 1.5,
      "editor.letterSpacing": 0,

      // Terminal font settings - Nerd Fonts only (for icons and symbols)
      "terminal.integrated.fontFamily": "'JetBrainsMono Nerd Font', 'FiraCode Nerd Font', 'MesloLGS Nerd Font', 'Hack Nerd Font', 'SF Mono', Monaco, 'Cascadia Code', monospace",
      "terminal.integrated.fontSize": 13,
      "terminal.integrated.fontWeight": "400",
      "terminal.integrated.lineHeight": 1.4,
      "terminal.integrated.fontLigatures": true,

      // Editor settings
      "editor.tabSize": 2,
      "editor.insertSpaces": true,
      "editor.detectIndentation": false,
      "editor.formatOnSave": true,
      "editor.formatOnPaste": true,
      "editor.minimap.enabled": true,
      "editor.bracketPairColorization.enabled": true,
      "editor.guides.bracketPairs": "active",
      "editor.renderWhitespace": "selection",
      "editor.rulers": [],  // No vertical ruler lines (removed 80, 120 character markers)
      "editor.wordWrap": "on",
      "editor.smoothScrolling": true,
      "editor.cursorBlinking": "smooth",
      "editor.cursorSmoothCaretAnimation": "on",
      "workbench.scrollbar.vertical": "hidden",  // Hide right scrollbar
      "workbench.scrollbar.horizontal": "auto",  // Keep bottom scrollbar for long lines

      // File settings
      "files.autoSave": "afterDelay",
      "files.autoSaveDelay": 1000,
      "files.trimTrailingWhitespace": true,
      "files.insertFinalNewline": true,
      "files.exclude": {
        "**/.git": true,
        "**/.DS_Store": true,
        "**/node_modules": true,
        "**/.next": true,
        "**/dist": true,
        "**/build": true
      },

      // Git settings
      "git.enableSmartCommit": true,
      "git.confirmSync": false,
      "git.autofetch": true,

      // Explorer settings
      "explorer.confirmDelete": false,
      "explorer.confirmDragAndDrop": false,

      // Workbench settings
      "workbench.editor.enablePreview": false,
      "workbench.startupEditor": "newUntitledFile",

      // Disable spell checking (even if extension is installed)
      "cSpell.enabled": false,
      "cSpell.enableFiletypes": [],
      "editor.quickSuggestions": {
        "strings": false
      },

      // Suppress Nix IDE warnings and notifications
      "problems.showCurrentInStatus": false,
      "notifications": {
        "doNotDisturbMode": false
      },

      // Language-specific settings
      "[json]": {
        "editor.defaultFormatter": "vscode.json-language-features",
        "editor.formatOnSave": true
      },
      "[jsonc]": {
        "editor.defaultFormatter": "vscode.json-language-features",
        "editor.formatOnSave": true
      },
      "[javascript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode",
        "editor.formatOnSave": true
      },
      "[typescript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode",
        "editor.formatOnSave": true
      },
      "[python]": {
        "editor.defaultFormatter": "ms-python.black-formatter",
        "editor.formatOnSave": true,
        "editor.tabSize": 4
      },
      "[nix]": {
        "editor.tabSize": 2,
        "editor.formatOnSave": false,  // Disable format on save to avoid formatter warnings
        "editor.defaultFormatter": null  // Disable formatter to suppress warnings
      },

      // Nix IDE extension settings
      "nix.enableLanguageServer": true,
      "nix.serverPath": "nil",
      "nix.formatterPath": "nixpkgs-fmt",
      "nix.showNixOSOptions": false,
      "nix.serverSettings": {
        "nil": {
          "formatting": {
            "command": [ "nixpkgs-fmt" ]
          },
          "diagnostics": {
            "ignored": [
              "unused_binding",
              "unused_with",
              "dead_code"
            ]
          }
        },
        "nixd": {
          "formatting": {
            "command": [ "nixpkgs-fmt" ]
          },
          "options": {
            "nix-darwin": {
              "expr": "(builtins.getFlake \"''${workspaceFolder}\").darwinConfigurations.macbook-pro-3.options"
            }
          }
        }
      },
      "[terraform]": {
        "editor.defaultFormatter": "hashicorp.terraform",
        "editor.formatOnSave": true,
        "editor.tabSize": 2
      },
      "[hcl]": {
        "editor.defaultFormatter": "hashicorp.terraform",
        "editor.formatOnSave": true,
        "editor.tabSize": 2
      },
      "[yaml]": {
        "editor.tabSize": 2,
        "editor.insertSpaces": true
      },
      "[markdown]": {
        "editor.wordWrap": "on",
        "editor.quickSuggestions": {
          "comments": "off",
          "strings": "off",
          "other": "off"
        }
      }
    }
  '';
  };

  home.file."Library/Application Support/Cursor/User/keybindings.json" = {
    force = true;
    text = ''
    // Place your key bindings in this file to override the defaults
    [
      {
        "key": "cmd+i",
        "command": "composerMode.agent"
      }
    ]
  '';
  };

  # Recommended extensions list
  # This file helps Cursor suggest extensions to install
  home.file."Library/Application Support/Cursor/User/extensions.json".text = ''
    {
      "recommendations": [
        // Language Support
        "ms-python.python",
        "ms-python.vscode-pylance",
        "golang.go",
        "rust-lang.rust-analyzer",
        "nix-community.nixvim",

        // Formatting & Linting
        "esbenp.prettier-vscode",
        "dbaeumer.vscode-eslint",
        "ms-python.black-formatter",
        "ms-python.isort",
        "ms-python.flake8",

        // Git
        "eamodio.gitlens",
        "mhutchie.git-graph",
        "github.vscode-github-actions,

        // UI & Themes
        "pkief.material-icon-theme",
        "zhuangtongfa.material-theme",
        "catppuccin.catppuccin-vsc",

        // Productivity
        "usernamehw.errorlens",
        "redhat.vscode-yaml",
        "ms-vscode.hexeditor",

        // Docker & Containers
        "ms-azuretools.vscode-docker",

        // Markdown
        "yzhang.markdown-all-in-one",
        "davidanson.vscode-markdownlint",

        // Terminal
        "formulahendry.auto-rename-tag",
        "christian-kohler.path-intellisense",

        // Nix
        "jnoortheen.nix-ide",

        // Terraform & Terragrunt
        "hashicorp.terraform",
        "4ops.terraform",

        // Utilities
        "github.copilot",
        "github.copilot-chat"
      ]
    }
  '';

  # Automatically install Cursor extensions
  # This runs after Home Manager files are set up
  home.activation.installCursorExtensions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    echo "Installing Cursor extensions..."

    # Find Cursor CLI - try common locations
    CURSOR_CLI=""
    if [ -f "/Applications/Cursor.app/Contents/Resources/app/bin/cursor" ]; then
      CURSOR_CLI="/Applications/Cursor.app/Contents/Resources/app/bin/cursor"
    elif [ -f "$HOME/Applications/Cursor.app/Contents/Resources/app/bin/cursor" ]; then
      CURSOR_CLI="$HOME/Applications/Cursor.app/Contents/Resources/app/bin/cursor"
    elif command -v cursor >/dev/null 2>&1; then
      CURSOR_CLI="cursor"
    fi

    if [ -z "$CURSOR_CLI" ]; then
      echo "Warning: Cursor CLI not found. Extensions will not be installed automatically."
      echo "Please install Cursor first, or install extensions manually from the Extensions view."
      exit 0
    fi

    # Uninstall spell checker if present
    echo "Removing spell checker extension if installed..."
    $CURSOR_CLI --uninstall-extension "streetsidesoftware.code-spell-checker" 2>/dev/null || true

    # Get list of already installed extensions
    INSTALLED_EXTS=$($CURSOR_CLI --list-extensions 2>/dev/null || echo "")

    # Install only missing extensions
    INSTALLED_COUNT=0
    SKIPPED_COUNT=0

    for ext in ${builtins.concatStringsSep " " (map (ext: "\"${ext}\"") cursorExtensions)}; do
      if echo "$INSTALLED_EXTS" | grep -q "^$ext$"; then
        echo "✓ Extension already installed: $ext"
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
      else
        echo "Installing extension: $ext"
        if $CURSOR_CLI --install-extension "$ext" 2>/dev/null; then
          INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
        else
          echo "  ⚠ Failed to install: $ext"
        fi
      fi
    done

    echo ""
    echo "Cursor extensions: $INSTALLED_COUNT installed, $SKIPPED_COUNT already present"
  '';
}

