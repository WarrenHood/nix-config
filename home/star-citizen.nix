{ pkgs, inputs, ... }: {
  home.packages = [
    (inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.star-citizen.override {
      tricks = [ "arial" "vcrun2019" "win10" "sound=alsa" ];
      gameScopeEnable = false;
      location = "/games/star-citizen";
    })
  ];
}
