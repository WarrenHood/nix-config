# Gaming base
{inputs, ...}: {
  flake.modules.nixos.gamingBase = {pkgs, ...}: {
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
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
          ];
      };
    };

    programs.steam = {enable = true;};

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
    ];

    # Enable gamescope and platform optimisations
    programs.gamescope.enable = true;
    programs.steam.platformOptimizations.enable = true;

    # Controller support
    services.joycond.enable = true;
    programs.joycond-cemuhook.enable = true;

    hardware.uinput.enable = true;
    services.udev.packages = [pkgs.game-devices-udev-rules];

    # Gamemode
    programs.gamemode.enable = true;
    # TODO: Fix. This is a hack but my username will always be warren
    users.users.warren.extraGroups = ["gamemode"];
  };
}
