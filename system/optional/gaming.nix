# Common gaming stuff

user: { ... }: {
  imports = [
    (import ./gamemode.nix user)
    ./steam.nix
    ./r2modman.nix
  ];

  # Controller support
  services.joycond.enable = true;
  programs.joycond-cemuhook.enable = true;

}