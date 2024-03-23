{...}: {
  services.xserver.layout = "us";

  # xserver and sddm
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;

  # Enable pipewire service and rtkit
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # gnome-keyring
  services.gnome.gnome-keyring.enable = true;
}
