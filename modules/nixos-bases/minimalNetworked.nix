# The minimal base system but with networking
{self, ...}: {
  flake.modules.nixos.minimalNetworkedBase = {
    imports = [
      self.modules.nixos.minimalBase
      {
        networking.networkmanager.enable = true;
      }
    ];
  };
}
