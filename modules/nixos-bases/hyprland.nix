# Base hyprland module
{self, ...}: {
  flake.modules.nixos.hyprlandBase = {pkgs, ...}: {
    imports = [
      self.modules.nixos.minimalGraphicalBase
    ];

    # Actually enable hyprland
    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;

    # Enable portals
    xdg.portal = {
      enable = true;
      config.common.default = "*";
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        # pkgs.xdg-desktop-portal-gnome
        # pkgs.xdg-desktop-portal-gtk
      ];
    };

    # Sys packages for hyprland
    environment.systemPackages = with pkgs; [
      # Things i'll probably only need on Hyprland
      wofi
      waybar
      grim
      slurp
      swappy
      wl-clipboard # Screenshots in wayland
      hyprpaper # Set wallpapers on Hyprland

      # Breeze Theme
      # pkgs.libsForQt5.breeze-gtk
      pkgs.libsForQt5.breeze-icons

      # SDDM Theme
      (pkgs.where-is-my-sddm-theme.override {
        themeConfig.General = {
          background = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          backgroundMode = "none";
        };
      })
    ];
  };
}
