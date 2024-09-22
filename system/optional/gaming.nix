# Common gaming stuff

user: { pkgs, ... }: {
  imports = [
    (import ./gamemode.nix user)
    ./steam.nix
    ./r2modman.nix
  ];

  # Controller support
  services.joycond.enable = true;
  programs.joycond-cemuhook.enable = true;

  hardware.uinput.enable = true;
  services.udev.packages = [ pkgs.game-devices-udev-rules ];
}