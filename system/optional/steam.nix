{ ... }: {
  programs.steam = {
    enable = true;
  };

  # Controller support
  hardware.steam-hardware.enable = true;
}