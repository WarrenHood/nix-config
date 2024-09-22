{
  description = "NixOS System Config Flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      # url = "github:nix-community/home-manager/release-24.05";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My minecraft modpack manager
    mcmpmgr = {
      url = "github:WarrenHood/MCModpackManager";
    };

    # Anime games
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, mcmpmgr, aagl, auto-cpufreq, ... }@inputs:
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

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = import ./home;
          home-manager.extraSpecialArgs = { inherit user; };
        }

        # auto-cpufreq.nixosModules.default
      ];
    };
    nixosConfigurations.g14 = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ({pkgs, ...}: {
          imports = [
            ./system
            ./hosts/g14.nix
            ./system/optional/nvidia-g14.nix
            ./system/optional/asus.nix
            ./system/optional/amd.nix
            (import ./system/optional/animegames.nix aagl)
            (import ./system/optional/gaming.nix user)
            (import ./system/razer user)
            aagl.nixosModules.default
          ];
        })

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = import ./home;
          home-manager.extraSpecialArgs = { inherit user; inherit mcmpmgr; inherit system; };
        }
        
        auto-cpufreq.nixosModules.default
      ];
    };
  };
}
