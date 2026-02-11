{
  inputs,
  self,
  ...
}: {
  flake.modules.homeManager.discord = {
    pkgs,
    config,
    ...
  }: {
    home.packages = with pkgs; [
      vesktop
    ];
  };
}
