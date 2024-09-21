{...}: {
  # We'll use systemd-boot for now...
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable NTFS at boot
  boot.supportedFilesystems = [ "ntfs" ];
}
