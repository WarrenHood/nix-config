{...}: {
  flake.modules.nixos.waylandBase = {...}: {
    environment.variables = {
      # Ask chromium based apps to run natively on Wayland
      NIXOS_OZONE_WL = "1";
    };
  };

  flake.modules.homeManager.waylandBase = {pkgs, ...}: {
    programs.fuzzel = {
      enable = true;
      settings = {
        colors = {
          background = "161616ff";
          text = "ffffffff";
          match = "ee5396ff";
          selection-match = "ee5396ff";
          selection = "262626ff";
          selection-text = "33b1ffff";
          border = "525252ff";
        };
      };
    };

    home.packages = with pkgs; [
      grim # Screenshots
      slurp # Select rects
      satty # Annotations of screenshots
      wl-clipboard # Wayland clipboard
    ];

    # Swaylock with a gray background
    programs.swaylock = {
      enable = true;
      settings = {
        color = "111111";
        show-failed-attempts = true;
      };
    };

    # Flameshot
    # TODO: Flameshot is broken in niri for me... Figure out how to get it working nicely
    # services.flameshot = {
    #   enable = true;
    #   settings = {
    #     # See flameshot example settings at https://github.com/flameshot-org/flameshot/blob/master/flameshot.example.ini
    #     General = {
    #       showDesktopNotification = true;
    #       useGrimAdapter = true;
    #     };
    #   };
    # };

    home.sessionVariables = {
      # Ask chromium based apps to run natively on Wayland
      NIXOS_OZONE_WL = "1";
    };

    # Use the breeze cursor theme
    home.pointerCursor = {
      package = pkgs.kdePackages.breeze;
      name = "breeze_cursors";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
