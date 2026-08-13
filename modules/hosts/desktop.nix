{ inputs
, self
, ...
}: {
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self.modules.nixos; [
      # This is a graphical system
      minimalGraphicalBase

      # DE/Compositor
      niri
      # hyprland

      # I game on here with nvidia graphics
      self.modules.nixos.gamingBase
      self.modules.nixos.nvidiaBase

      # Home manager NixOS module
      inputs.home-manager.nixosModules.home-manager

      # Home manager configuration
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.warren = {
          imports = with self.modules.homeManager; [
            warren
            codingBase
            gamingBase
            niriConfig
            noctaliaShell

            ({ pkgs, lib, ... }: {
              # # Force disable kanshi since it cannot enable VRR sadly...
              services.kanshi.enable = lib.mkForce false;

              # Enable VRR on the alienware monitor on niri
              programs.niri.settings =
                {
                  outputs = {
                    # Alienware monitor
                    "Dell Inc. AW2725DF JRS7ZZ3" = {
                      variable-refresh-rate = "on-demand";
                      mode = {
                        width = 2560;
                        height = 1440;
                        refresh = 359.979;
                      };
                      position = { x = 0; y = 0; };
                    };

                    # Shitty 1080p AoC monitor
                    "PNP(AOC) 24G2W1G4 ATNL61A180277" = {
                      mode =
                        {
                          width = 1920;
                          height = 1080;
                          refresh = 144.000;
                        };
                      position = { x = 2560; y = 0; };
                    };
                  };

                  window-rules = [
                    {
                      matches = [
                        {
                          app-id = "^steam_app_";
                        }
                        {
                          app-id = "\\.exe$";
                        }
                        {
                          app-id = "^osu!$";
                        }
                      ];
                      variable-refresh-rate = true;
                    }
                  ];
                };

              home.packages = with pkgs; [
                osu-lazer-bin
                prismlauncher
                krita
              ];
            })

          ];
        };
      }

      # Pen tablet config
      ({ ... }: {
        hardware.opentabletdriver.enable = true;
        hardware.uinput.enable = true;
        boot.kernelModules = [ "uinput" ];
      })

      # Host specific config
      ({ config, lib, pkgs, modulesPath, ... }:

        {
          networking.hostName = "nixos-pc";

          # Zen kernel
          # boot.kernelPackages = pkgs.linuxPackages_zen;
          boot.kernelPackages =
            let
              nixpkgs-unfree = inputs.nixpkgs-unfree.legacyPackages.${pkgs.stdenv.hostPlatform.system};
            in
            lib.mkForce nixpkgs-unfree.linuxKernel.packages.linux_xanmod_latest;

          # # Use KDE Plasma 6
          # services.desktopManager.plasma6.enable = true;
          # # Blueman is really not needed with KDE Plasma
          # services.blueman.enable = lib.mkForce false;

          # Temurin JRE
          environment.systemPackages = with pkgs; [
            temurin-jre-bin
            cataclysm-dda
          ];

          imports =
            [
              (modulesPath + "/installer/scan/not-detected.nix")
            ];

          boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "thunderbolt" "usbhid" ];
          boot.initrd.kernelModules = [ ];
          boot.kernelModules = [ "kvm-amd" ];
          boot.extraModulePackages = [ ];

          fileSystems."/" =
            {
              device = "/dev/disk/by-uuid/47e6a2a1-dff2-494e-afe2-404c7880944a";
              fsType = "ext4";
            };

          fileSystems."/boot" =
            {
              device = "/dev/disk/by-uuid/9540-F22B";
              fsType = "vfat";
              options = [ "fmask=0077" "dmask=0077" ];
            };

          swapDevices = [ ];

          zramSwap = {
            enable = true;
          };

          nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
          hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        })
    ];
  };
}
