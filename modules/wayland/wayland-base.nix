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
