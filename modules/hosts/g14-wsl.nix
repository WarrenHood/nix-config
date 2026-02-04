{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.g14-wsl = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.modules.nixos.minimalBase
      # Host specific config
      {
        imports = [
          # include NixOS-WSL modules
          <nixos-wsl/modules>
        ];

        networking.hostName = "g14-wsl";
        wsl.enable = true;
        wsl.defaultUser = "warren";
      }
    ];
  };
}
