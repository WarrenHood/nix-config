{
  inputs,
  self,
  ...
}: {
  flake.modules.homeManager.warren = {
    pkgs,
    config,
    ...
  }: {
    home.username = "warren";
    home.homeDirectory = "/home/warren";
  };
}
