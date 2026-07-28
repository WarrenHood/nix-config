# Gaming base
{ inputs, ... }: {
  flake.modules.nixos.gamingBase = { pkgs, ... }: {
    imports = [
      inputs.nix-gaming.nixosModules.platformOptimizations
      inputs.nix-gaming.nixosModules.pipewireLowLatency
    ];

    nixpkgs.config.packageOverrides = pkgs: {
      # Fix gamescope windows not showing on Hyprland
      # See https://github.com/ValveSoftware/gamescope/issues/905
      steam = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            libgdiplus
            keyutils
            libkrb5
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            libxcursor
            libxi
            libxinerama
            libxscrnsaver
          ];
      };
    };

    programs.steam = {
      enable = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    # Controller support
    hardware.steam-hardware.enable = true;

    services.pipewire.lowLatency = {
      enable = true;
      # quantum = 64;
      # rate = 48000;
    };

    # Lutris
    environment.systemPackages = with pkgs; [
      (lutris.override {
        extraLibraries = pkgs: [
          # List library dependencies here
        ];
      })
      protonup-qt
      protonplus
    ];

    # Enable gamescope and platform optimisations
    programs.gamescope.enable = true;
    programs.steam.platformOptimizations.enable = true;

    # Controller support
    services.joycond.enable = true;
    programs.joycond-cemuhook.enable = true;

    hardware.uinput.enable = true;
    services.udev.packages = [ pkgs.game-devices-udev-rules ];

    # Gamemode
    programs.gamemode.enable = true;
    programs.gamemode.settings = {
      cpu = {
        park_cores = "no";
        pin_cores = "yes";
        amd_x3d_mode_desired = "cache";
        amd_x3d_mode_default = "frequency";
      };
    };

    # TODO: Fix. This is a hack but my username will always be warren
    users.users.warren.extraGroups = [ "gamemode" ];

    # BBR + FQ - better network performance
    boot.kernel.sysctl = {
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.tcp_slow_start_after_idle" = 0;
    };
  };
}
