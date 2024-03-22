{...}: {
  services.xserver = {
    # Might need X for some apps
    enable = true;
    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
    # Default to hyprland
    displayManager.defaultSession = "hyprland";
  };

  # Enable SDDM coz we need a display manager
  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
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
}
