{
  pkgs,
  lib,
  config,
  user,
  ...
}:
with lib; let
  cfg = config.servers.vintage_story;
  vs_server = lib.callPackageWith pkgs ./package.nix {inherit cfg;};
  stop_wrapper = pkgs.writeShellScriptBin "vs-server-stop-wrapper" ''
    #!${pkgs.runtimeShell}
    # This script asks the vintage story server to stop gracefully, and waits for its screen session to end

    # Send the /stop 0 command to the screen session and wait for it to finish
    ${pkgs.screen}/bin/screen -XS vintage_story_server stuff '/stop 0\n'

    # Wait for the screen session to terminate gracefully
    while ${pkgs.screen}/bin/screen -ls | grep -q vintage_story_server; do
      sleep 1
    done

    echo "Vintage Story Server gracefully stopped."
  '';
in {
  options = {
    servers.vintage_story = {
      enable = mkEnableOption "Vintage Story Server";
      dataPath = mkOption {
        type = types.path;
        default = "${config.users.users.${user}.home}/.server_data/vintage_story";
      };
      version = mkOption {
        type = types.str;
        default = "1.20.9";
      };
      server_hash = mkOption {
        type = types.str;
        default = "sha256-a5Hk3xdOmXrfNgLVzA/OHdDrTTfPKqsyVpiMTbYXNHw=";
      };
      dotnet_runtime_package = mkOption {
        type = types.package;
        default = pkgs.dotnet-runtime_8;
      };
      net_framework_version = mkOption {
        type = types.str;
        default = "8.0.0";
      };
      net_tfm = mkOption {
        type = types.str;
        default = "net8.0";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.vintage_story_server = {
      description = "Vintage Story Server";
      after = ["network-online.target"];
      wants = ["network-online.target"];
      wantedBy = ["default.target"];
      serviceConfig = {
        User = user;
        Group = "users";
        SupplementaryGroups = ["users"];
        ExecStartPre = [
          # Ensure the data directory exists
          "${pkgs.coreutils}/bin/mkdir -p \"${cfg.dataPath}\""

          # Kill any existing screen sessions
          "-${pkgs.screen}/bin/screen -XS vintage_story_server quit"
        ];
        ExecStart = "${pkgs.screen}/bin/screen -L -dmS vintage_story_server ${vs_server}/bin/vintagestory-server --dataPath=\"${cfg.dataPath}\"";
        ExecStop = "${stop_wrapper}/bin/vs-server-stop-wrapper";
        TimeoutStopSec = 30;
        Type = "forking";
        WorkingDirectory = cfg.dataPath;
      };
    };
  };
}
