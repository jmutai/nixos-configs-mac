{
  # Keyboard remapping: ±§ → `~
  # Using Karabiner Elements configuration for reliable key remapping
  # Karabiner Elements is already installed via Homebrew Cask
  # This automatically creates and enables the remapping rule
  system.activationScripts.keyboardRemap = ''
    # Create Karabiner Elements directories
    mkdir -p ~/.config/karabiner/assets/complex_modifications
    
    # Create remapping rule for ±§ → `~
    cat > ~/.config/karabiner/assets/complex_modifications/pm_to_tilde.json << 'EOF'
{
  "title": "Remap ±§ to `~",
  "rules": [
    {
      "description": "Change ±§ key to grave/tilde (`~)",
      "manipulators": [
        {
          "type": "basic",
          "from": {
            "key_code": "non_us_backslash",
            "modifiers": {
              "optional": ["any"]
            }
          },
          "to": [
            {
              "key_code": "grave_accent_and_tilde"
            }
          ]
        }
      ]
    }
  ]
}
EOF
    
    # Create or update Karabiner Elements main configuration
    KARABINER_CONFIG="$HOME/.config/karabiner/karabiner.json"
    
    # If config doesn't exist, create it with basic structure
    if [ ! -f "$KARABINER_CONFIG" ]; then
      cat > "$KARABINER_CONFIG" << 'JSONEOF'
{
  "global": {
    "check_for_updates_on_startup": true,
    "show_in_menu_bar": true,
    "show_profile_name_in_menu_bar": false
  },
  "profiles": [
    {
      "name": "Default profile",
      "selected": true,
      "complex_modifications": {
        "rules": []
      }
    }
  ]
}
JSONEOF
    fi
    
    # Use Python to safely update the JSON config (add rule if not present)
    python3 << 'PYEOF'
import json
import os
import sys

config_path = os.path.expanduser("~/.config/karabiner/karabiner.json")

try:
    # Read existing config
    with open(config_path, 'r') as f:
        config = json.load(f)
except (FileNotFoundError, json.JSONDecodeError):
    # Create default config if file doesn't exist or is invalid
    config = {
        "global": {
            "check_for_updates_on_startup": True,
            "show_in_menu_bar": True,
            "show_profile_name_in_menu_bar": False
        },
        "profiles": [
            {
                "name": "Default profile",
                "selected": True,
                "complex_modifications": {
                    "rules": []
                }
            }
        ]
    }

# Find the selected profile
selected_profile = None
for profile in config.get("profiles", []):
    if profile.get("selected", False):
        selected_profile = profile
        break

if not selected_profile:
    # If no selected profile, use the first one or create one
    if config.get("profiles"):
        selected_profile = config["profiles"][0]
    else:
        selected_profile = {
            "name": "Default profile",
            "selected": True,
            "complex_modifications": {"rules": []}
        }
        config.setdefault("profiles", []).append(selected_profile)

# Ensure complex_modifications exists
if "complex_modifications" not in selected_profile:
    selected_profile["complex_modifications"] = {"rules": []}
if "rules" not in selected_profile["complex_modifications"]:
    selected_profile["complex_modifications"]["rules"] = []

# Add rule if it doesn't exist
rule_exists = False
rule_id = "pm_to_tilde"
for rule in selected_profile["complex_modifications"]["rules"]:
    if rule.get("id") == rule_id:
        rule_exists = True
        break

if not rule_exists:
    selected_profile["complex_modifications"]["rules"].append({
        "id": rule_id,
        "description": "Change ±§ key to grave/tilde (`~)",
        "manipulators": [
            {
                "type": "basic",
                "from": {
                    "key_code": "non_us_backslash",
                    "modifiers": {"optional": ["any"]}
                },
                "to": [{"key_code": "grave_accent_and_tilde"}]
            }
        ]
    })

# Write updated config
with open(config_path, 'w') as f:
    json.dump(config, f, indent=4)

# Reload Karabiner Elements configuration
os.system("launchctl kickstart -k gui/$(id -u)/org.pqrs.karabiner.karabiner_console_user_server 2>/dev/null || true")
PYEOF
  '';
}

