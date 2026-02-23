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

      # Home manager NixOS module
      inputs.home-manager.nixosModules.home-manager

      # Home manager configuration
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        environment.pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];
        home-manager.backupFileExtension = "backup";
        home-manager.users.warren = {
          imports = with self.modules.homeManager; [
            minimalBase
            warren
          ];
        };
      }
    ];
  };
}
