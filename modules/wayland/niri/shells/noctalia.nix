{ inputs, ... }: {
  flake.modules.homeManager.noctaliaShell = { config, ... }: {
    imports = [
      # Noctalia shell home manager module
      inputs.noctalia.homeModules.default
    ];

    programs.niri.settings = {
      spawn-at-startup = [
        { argv = [ "noctalia" ]; }
      ];
    };

    # Enable noctalia shell
    programs.noctalia = {
      enable = true;

      settings = {
        bar = {
          order = [ "default" ];

          default = {
            position = "top";

            start = [
              "launcher"
              "sysmon"
              "active_window"
              "media"
            ];
            center = [
              "workspaces"
            ];
            end = [
              "tray"
              "notifications"
              "clipboard"
              "battery"
              "network"
              "bluetooth"
              "volume"
              "brightness"
              "clock"
              "control-center"
              "session"
            ];
          };
        };

        config = {
          use_wallpaper_colors = true;
          predefined_scheme = "Gruvbox";
          dark_mode = true;
          scheduling_mode = "off";
          manual_sunrise = "06:30";
          manual_sunset = "18:30";
          generation_method = "tonal-spot";
          monitor_for_colors = "";
          sync_gsettings = true;
        };

        wallpaper = {
          directory = "${config.home.homeDirectory}/.wallpapers";
        };
      };
    };


  };
}
