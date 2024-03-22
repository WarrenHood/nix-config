{...}: {
  # We'll use systemd-boot for now...
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
