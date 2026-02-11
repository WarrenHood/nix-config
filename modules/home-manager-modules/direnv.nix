{
  inputs,
  self,
  ...
}: {
  flake.modules.homeManager.direnv = {
    pkgs,
    config,
    ...
  }: {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      nix-direnv.enable = true; # Faster
    };
  };
}
