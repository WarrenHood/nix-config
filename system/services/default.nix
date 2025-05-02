{ lib, config, ... }:
with lib;
let cfg = config;
in {
  services.xserver.xkb.layout = "us";

  # xserver and sddm
  services.xserver.enable = mkIf (!cfg.headless) true;
  services.displayManager.sddm = mkIf (!cfg.headless) {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
    autoNumlock = true;
    # theme = "where_is_my_sddm_theme";
    settings = { Theme = { CursorTheme = "breeze_cursors"; }; };
  };

  # Enable pipewire service and rtkit
  security.rtkit.enable = mkIf (!cfg.headless) true;
  services.pipewire = mkIf (!cfg.headless) {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Bluetooth
  services.blueman.enable = true;

  # gnome-keyring
  services.gnome.gnome-keyring.enable = mkIf (!cfg.headless) true;
}
