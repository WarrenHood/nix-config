{
  description = "NixOS System Config Flake";

  inputs = {
    # Unstable branch for now
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unfree = {
      url = "github:numtide/nixpkgs-unfree";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      # url = "github:nix-community/home-manager"; # Unstable
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My minecraft modpack manager
    mcmpmgr = {
      url = "github:WarrenHood/MCModpackManager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Anime games
    aagl = {
      # url = "github:ezKEa/aagl-gtk-on-nix"; # Unstable
      url = "github:ezKEa/aagl-gtk-on-nix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Nix gaming stuff
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, mcmpmgr, aagl, auto-cpufreq, ... }@inputs:
    let
      system = "x86_64-linux";
      user = "warren";
    in
    {
      nixosConfigurations.dell3550 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; inherit system; inherit user; };
        modules = [
          ({ pkgs, ... }: {
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
            home-manager.backupFileExtension = "backup"; 
            home-manager.extraSpecialArgs = { inherit user; };
          }

          # auto-cpufreq.nixosModules.default
        ];
      };
      nixosConfigurations.g14 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; inherit system; inherit user; };
        modules = [
          ({ pkgs, ... }: {
            imports = [
              ./system
              ./hosts/g14.nix
              ./system/optional/nvidia-g14.nix
              ./system/optional/asus.nix
              ./system/optional/amd.nix
              ./system/optional/animegames.nix
              ./system/optional/gaming.nix
              ./system/optional/docker.nix
              ./system/optional/waydroid.nix
              ./system/razer
              ./overlays
              aagl.nixosModules.default
            ];
          })

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ./home;
            home-manager.backupFileExtension = "backup"; 
            home-manager.extraSpecialArgs = { inherit user; inherit mcmpmgr; inherit system; inherit inputs; };
          }

          auto-cpufreq.nixosModules.default
        ];
      };
    };
}
