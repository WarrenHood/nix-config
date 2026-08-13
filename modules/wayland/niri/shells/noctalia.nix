{ inputs, ... }: {
  flake.modules.homeManager.noctaliaShell = { config, ... }: {
    imports = [
      # Noctalia shell home manager module
      inputs.noctalia.homeModules.default
    ];

    programs.niri.settings = {
      spawn-at-startup = [
        { argv = [ "noctalia-shell" ]; }
      ];
    };

    # Enable noctalia shell
    programs.noctalia-shell = {
      enable = true;

      # Reference config at: https://docs.noctalia.dev/noctalia-shell/getting-started/nixos/?section=config-ref#config-ref
      settings = {
        bar = {
          barType = "simple";
          position = "top";
          monitors = [ ];
          density = "compact";
          widgets = {
            left = [
              {
                id = "Launcher";
              }
              {
                id = "SystemMonitor";
              }
              {
                id = "ActiveWindow";
              }
              {
                id = "MediaMini";
              }
            ];
            center = [
              {
                id = "Workspace";
              }
            ];
            right = [
              {
                id = "Tray";
              }
              {
                id = "NotificationHistory";
              }
              {
                id = "Battery";
              }
              {
                id = "Volume";
              }
              {
                id = "Brightness";
              }
              {
                id = "Clock";
              }
              {
                id = "ControlCenter";
              }
            ];
          };
        };
        colorSchemes = {
          useWallpaperColors = true;
          predefinedScheme = "Gruvbox";
          darkMode = true;
          schedulingMode = "off";
          manualSunrise = "06:30";
          manualSunset = "18:30";
          generationMethod = "tonal-spot";
          monitorForColors = "";
          syncGsettings = true;
        };
        wallpaper = {
          directory = "${config.home.homeDirectory}/.wallpapers";
        };
      };
    };
  };
}
