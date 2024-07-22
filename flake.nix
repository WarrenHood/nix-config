{
  description = "NixOS System Config Flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager,... }@inputs: 
  let
    system = "x86_64-linux";
    user = "warren";
  in 
  {
    nixosConfigurations.dell3550 = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ({pkgs, ...}: {
          imports = [
            ./system
            ./hosts/dell3550.nix
          ];
        })

        home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ./home;
            home-manager.extraSpecialArgs = { inherit user; };
          }
      ];
    };
    nixosConfigurations.g14 = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ({pkgs, ...}: {
          imports = [
            ./system
            ./hosts/g14.nix
            ./system/nvidia-g14
          ];
        })

        home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ./home;
            home-manager.extraSpecialArgs = { inherit user; };
          }
      ];
    };
  };
}
