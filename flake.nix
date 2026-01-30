{
  description = "NixOS System Config Flake";

  inputs = {
    # Unstable branch for now
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unfree = {
      url = "github:numtide/nixpkgs-unfree";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager"; # Unstable
      # url = "github:nix-community/home-manager/release-24.11";
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
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);

  # outputs = {
  #   self,
  #   flake-parts,
  #   nixpkgs,
  #   nixpkgs-stable,
  #   nixpkgs-unfree,
  #   nixpkgs-unstable,
  #   home-manager,
  #   mcmpmgr,
  #   aagl,
  #   auto-cpufreq,
  #   determinate,
  #   ...
  # } @ inputs: let
  #   system = "x86_64-linux";
  #   user = "warren";
  #   pkgs = nixpkgs.legacyPackages.${system};
  #   pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
  #   pkgs-unfree = nixpkgs-unfree.legacyPackages.${system};
  # in
  #   flake-parts.lib.mkFlake {inherit inputs;} (top @ {
  #     config,
  #     withSystem,
  #     moduleWithSystem,
  #     ...
  #   }: {
  #     imports = [
  #       # Optional: use external flake logic, e.g.
  #       # inputs.foo.flakeModules.default
  #     ];
  #     flake = {
  #       formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

  #       nixosConfigurations.dell3550 = nixpkgs.lib.nixosSystem {
  #         inherit system;
  #         specialArgs = {
  #           inherit inputs;
  #           inherit system;
  #           inherit user;
  #           inherit pkgs-unstable;
  #           inherit nixpkgs-unstable;
  #           inherit pkgs-unfree;
  #         };
  #         modules = [
  #           ({...}: {
  #             imports = [./system ./system/optional/docker.nix ./hosts/dell3550.nix];
  #             headless = true;
  #             servers.vintage_story = {
  #               enable = true;
  #               version = "1.20.12";
  #               server_hash = "sha256-DqLHv9lVxXTG/qRJ2f6DFuJkB8gmHDAUiHD+d+RZpJQ=";
  #             };
  #           })

  #           # home-manager.nixosModules.home-manager
  #           # {
  #           #   nixpkgs.config.allowUnfree = true;
  #           #   home-manager.useGlobalPkgs = true;
  #           #   home-manager.useUserPackages = true;
  #           #   home-manager.users.${user} = import ./home;
  #           #   home-manager.backupFileExtension = "backup";
  #           #   home-manager.extraSpecialArgs = { inherit user; inherit pkgs-unstable; inherit pkgs-unfree; };
  #           # }

  #           auto-cpufreq.nixosModules.default

  #           determinate.nixosModules.default
  #         ];
  #       };
  #       nixosConfigurations.g14 = nixpkgs.lib.nixosSystem {
  #         inherit system;
  #         specialArgs = {
  #           inherit inputs;
  #           inherit system;
  #           inherit user;
  #           inherit pkgs-unstable;
  #           inherit nixpkgs-unstable;
  #           inherit pkgs-unfree;
  #         };
  #         modules = [
  #           ({...}: {
  #             imports = [
  #               ./system
  #               ./hosts/g14.nix
  #               ./system/optional/nvidia-g14.nix
  #               ./system/optional/asus.nix
  #               ./system/optional/amd.nix
  #               ./system/optional/animegames.nix
  #               ./system/optional/gaming.nix
  #               ./system/optional/docker.nix
  #               ./system/optional/waydroid.nix
  #               ./system/razer
  #               ./overlays
  #               aagl.nixosModules.default
  #             ];
  #           })

  #           home-manager.nixosModules.home-manager
  #           {
  #             nixpkgs.config.allowUnfree = true;
  #             home-manager.useGlobalPkgs = true;
  #             home-manager.useUserPackages = true;
  #             home-manager.users.${user} = import ./home;
  #             home-manager.backupFileExtension = "backup";
  #             home-manager.extraSpecialArgs = {
  #               inherit user;
  #               inherit mcmpmgr;
  #               inherit system;
  #               inherit inputs;
  #               inherit pkgs-unstable;
  #               inherit pkgs-unfree;
  #             };
  #           }

  #           auto-cpufreq.nixosModules.default

  #           determinate.nixosModules.default
  #         ];
  #       };

  #       nixosConfigurations.g14-wsl = nixpkgs.lib.nixosSystem {
  #         inherit system;
  #         specialArgs = {
  #           inherit inputs;
  #           inherit system;
  #           inherit user;
  #           inherit pkgs-unstable;
  #           inherit nixpkgs-unstable;
  #           inherit pkgs-unfree;
  #         };
  #         modules = [
  #           ({...}: {
  #             imports = [./system ./system/optional/docker.nix ./hosts/g14-wsl.nix];
  #             headless = true;
  #             bootloader = false;
  #           })

  #           determinate.nixosModules.default
  #         ];
  #       };
  #     };
  #     systems = [
  #       # systems for which you want to build the `perSystem` attributes
  #       "x86_64-linux"
  #       # ...
  #     ];
  #     perSystem = {
  #       config,
  #       pkgs,
  #       ...
  #     }: {
  #       # Recommended: move all package definitions here.
  #       # e.g. (assuming you have a nixpkgs input)
  #       # packages.foo = pkgs.callPackage ./foo/package.nix { };
  #       # packages.bar = pkgs.callPackage ./bar/package.nix {
  #       #   foo = config.packages.foo;
  #       # };
  #     };
  #   });
}
