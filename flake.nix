{
  description = "NixOS System Config Flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
  in 
  {
    nixosConfigurations.dell3550 = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ({pkgs, ...}: {
          imports = [
            ./configuration.nix
            ./hosts/dell3550.nix
          ];
        })
      ];
    };
  };
}
