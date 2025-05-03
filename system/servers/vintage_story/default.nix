{ inputs, pkgs, lib, config, user, system, ... }: with lib;
let
  cfg = config.servers.vintage_story;
  # pkgs = (import inputs.nixpkgs-unstable {
  #   inherit system;
  #   config = {
  #     allowUnfree = true;
  #     permittedInsecurePackages = [
  #       "dotnet-runtime-7.0.20"
  #     ];
  #   };
  # });
in
{
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

  imports = [ ./overlay.nix ];

  config = mkIf cfg.enable {
    systemd.services.vintage_story_server = {
      description = "Vintage Story Server";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig = {
        User = user;
        Group = "users";
        SupplementaryGroups = [ "users" ];
        ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p \"${cfg.dataPath}\"";
        ExecStart = "${pkgs.vintagestory}/bin/vintagestory-server --dataPath=\"${cfg.dataPath}\"";
      };
    };
  };
}
