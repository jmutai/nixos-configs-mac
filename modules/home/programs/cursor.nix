{ ... }:

{
  # Manage Cursor IDE configuration files
  # Cursor stores configs in ~/Library/Application Support/Cursor/User/
  # Since this is macOS-specific, we use home.file instead of xdg.configFile

  home.file."Library/Application Support/Cursor/User/settings.json".text = ''
    {
      // Window settings
      "window.commandCenter": true,
      "workbench.colorTheme": "Cursor Dark Midnight",
      
      // Editor font settings - Nerd Fonts
      "editor.fontFamily": "'JetBrains Mono', 'FiraCode Nerd Font', 'MesloLGS NF', 'SF Mono', Monaco, 'Cascadia Code', 'Source Code Pro', Menlo, Consolas, 'DejaVu Sans Mono', monospace",
      "editor.fontSize": 14,
      "editor.fontLigatures": true,
      "editor.fontWeight": "400",
      "editor.lineHeight": 1.6,
      "editor.letterSpacing": 0.5,
      
      // Terminal font settings - Nerd Fonts (explicitly set for terminal)
      "terminal.integrated.fontFamily": "'JetBrainsMono Nerd Font', 'FiraCode Nerd Font', 'MesloLGS Nerd Font', 'JetBrains Mono', 'Fira Code', 'MesloLGS NF', 'SF Mono', Monaco, 'Cascadia Code', monospace",
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
      "editor.rulers": [80, 120],
      "editor.wordWrap": "on",
      "editor.smoothScrolling": true,
      "editor.cursorBlinking": "smooth",
      "editor.cursorSmoothCaretAnimation": "on",
      
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
        "editor.formatOnSave": true
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

  home.file."Library/Application Support/Cursor/User/keybindings.json".text = ''
    // Place your key bindings in this file to override the defaults
    [
      {
        "key": "cmd+i",
        "command": "composerMode.agent"
      }
    ]
  '';

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
        
        // UI & Themes
        "pkief.material-icon-theme",
        "zhuangtongfa.material-theme",
        "catppuccin.catppuccin-vsc",
        
        // Productivity
        "usernamehw.errorlens",
        "streetsidesoftware.code-spell-checker",
        "ms-vscode.vscode-json",
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
        
        // Utilities
        "ms-vscode.remote-repositories",
        "github.copilot",
        "github.copilot-chat"
      ]
    }
  '';
}

