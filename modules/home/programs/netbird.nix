{ config, pkgs, lib, ... }:

{
  # NetBird VPN service configuration for macOS
  # NetBird is a WireGuard-based VPN that creates secure peer-to-peer connections
  # Packages are installed via modules/packages.nix

  # Configure NetBird service as a user LaunchAgent
  # This will start NetBird automatically when you log in
  launchd.agents.netbird = {
    enable = true;
    config = {
      ProgramArguments = [
        "${pkgs.netbird}/bin/netbird"
        "service"
        "run"
      ];
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "${config.home.homeDirectory}/Library/Logs/netbird.log";
      StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/netbird.error.log";

      # Optional: Set custom management URL
      # Uncomment and modify if you're using a self-hosted NetBird instance
      # EnvironmentVariables = {
      #   NETBIRD_MANAGEMENT_URL = "https://netbird.cloudlabske.com:443";
      # };
    };
  };

  # NetBird Network Configuration:
  # - Protocol: WireGuard (UDP)
  # - Default Port: 51820
  # - Interface: wt0
  #
  # macOS Firewall:
  # NetBird will automatically request firewall permissions on first run.
  # If needed, manually allow in: System Settings > Network > Firewall > Options
  #
  # Service Management:
  #   launchctl list | grep netbird                    # Check status
  #   launchctl stop com.netbird.client                # Stop service
  #   launchctl start com.netbird.client               # Start service
  #
  # NetBird Commands:
  #   netbird status                                   # Check connection status
  #   netbird up                                       # Connect to network
  #   netbird down                                     # Disconnect
  #   netbird up --management-url <URL>                # Connect with custom URL
  #
  # Config: ~/.config/netbird/config.json
}

