{ pkgs, user, ... }: {
  # Enable OpenRazer
  hardware.openrazer.enable = true;
  environment.systemPackages = with pkgs; [ openrazer-daemon polychromatic ];
  users.users.${user}.extraGroups = [ "gamemode" ];
}
