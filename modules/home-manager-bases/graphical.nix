{
  inputs,
  self,
  ...
}: {
  flake.modules.homeManager.graphicalBase = {pkgs, ...}: {
    imports = with self.modules.homeManager; [
      minimalBase
      graphical
      theme
    ];
  };
}
