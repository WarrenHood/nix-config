{
  inputs,
  self,
  ...
}: {
  flake.modules.homeManager.gamingBase = {pkgs, ...}: {
    imports = with self.modules.homeManager; [
      graphicalBase
      discord
    ];
  };
}
