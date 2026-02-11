{
  inputs,
  self,
  ...
}: {
  flake.modules.homeManager.codingBase = {pkgs, ...}: {
    imports = with self.modules.homeManager; [
      graphicalBase
      vscode
    ];
  };
}
