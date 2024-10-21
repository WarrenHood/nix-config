{...}: {
  services.xserver.xkb.layout = "us";

  # xserver and sddm
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
    autoNumlock = true;
    # theme = "where_is_my_sddm_theme";
     settings = {
      Theme = {
        CursorTheme = "breeze_cursors";
      };
    };
  };
  

  # Enable pipewire service and rtkit
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Bluetooth
  services.blueman.enable = true;

  # gnome-keyring
  services.gnome.gnome-keyring.enable = true;
}
