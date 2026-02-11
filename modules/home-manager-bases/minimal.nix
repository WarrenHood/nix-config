{
  inputs,
  self,
  ...
}: {
  flake.modules.homeManager.minimalBase = {
    pkgs,
    config,
    ...
  }: {
    imports = with self.modules.homeManager; [
      direnv
      cli
    ];

    home.stateVersion = "23.11";
    programs.home-manager.enable = true;
  };
}
