{
  inputs,
  self,
  ...
}: {
  flake.modules.nixos.niri = {pkgs, ...}: {
    imports = [
      inputs.niri.nixosModules.niri
    ];

    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];

    environment.variables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  flake.modules.homeManager.niriConfig = {pkgs, ...}: {
    imports = [
      # Noctalia shell home manager module
      inputs.noctalia.homeModules.default
    ];

    programs.niri.package = pkgs.niri;
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
    programs.niri.config = builtins.readFile "${self}/dotfiles/niri/config.kdl";

    # Enable noctalia shell
    programs.noctalia-shell = {
      enable = true;
    };

    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    home.packages = with pkgs; [
      xwayland-satellite
    ];

    # Enable gnome xdg portals for screensharing on Wayland (discord etc)
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gnome];
    xdg.portal.config = {
      common = {
        default = ["gnome"];
      };
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

  flake.modules.homeManager.niriStandalone = {pkgs, ...}: {
    imports = with self.modules.homeManager; [
      # Standalone niri home-manager module
      inputs.niri.homeModules.niri
      niriConfig
    ];

    # Enable niri
    programs.niri.enable = true;
  };
}
