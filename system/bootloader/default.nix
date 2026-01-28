{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config;
in {
  # We'll use systemd-boot for now...
  boot.loader = mkIf (cfg.bootloader) {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Enable NTFS at boot
  boot.supportedFilesystems = mkIf (cfg.bootloader) ["ntfs"];
}
