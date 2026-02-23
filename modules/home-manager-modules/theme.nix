{
  inputs,
  self,
  ...
}: {
  flake.modules.homeManager.theme = {
    pkgs,
    config,
    ...
  }: {
    gtk = {
      enable = true;

      colorScheme = "dark";
      gtk3.colorScheme = "dark";
      gtk4.colorScheme = "dark";

      # theme = {
      #   name = "Breeze-Dark";
      #   # package = pkgs.libsForQt5.breeze-gtk;
      # };
      # iconTheme = {
      #   name = "breeze-dark";
      #   # package = pkgs.libsForQt5.breeze-icons;
      # };
      # cursorTheme = {
      #   name = "breeze_cursors";
      #   # package = pkgs.libsForQt5.breeze-icons;
      # };
      gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    };

    # home.pointerCursor = {
    #   gtk.enable = true;
    #   name = "breeze_cursors";
    #   package = pkgs.libsForQt5.breeze-icons;
    #   size = 16;
    # };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Breeze-Dark";
        color-scheme = "prefer-dark";
      };
    };
  };
}
