# Common gaming stuff

{ pkgs, user, inputs, ... }: {
  imports = [
    (import ./gamemode.nix user)
    ./steam.nix
    ./r2modman.nix
    inputs.nix-gaming.nixosModules.platformOptimizations
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  services.pipewire.lowLatency = {
    enable = true;
    # quantum = 64;
    # rate = 48000;
  };

  # Enable gamescope and platform optimisations
  programs.gamescope.enable = true;
  programs.steam.platformOptimizations.enable = true;

  # Controller support
  services.joycond.enable = true;
  programs.joycond-cemuhook.enable = true;

  hardware.uinput.enable = true;
  services.udev.packages = [ pkgs.game-devices-udev-rules ];
}
