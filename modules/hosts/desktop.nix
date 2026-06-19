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
      # niri
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
            # niriConfig
            # noctaliaShell

            ({pkgs, ...}: {
              home.packages = with pkgs; [
                osu-lazer-bin
                prismlauncher
              ];
            })

          ];
        };
      }

      # Host specific config
      ({ config, lib, pkgs, modulesPath, ... }:

        {
          networking.hostName = "nixos-pc";

          # Zen kernel
          boot.kernelPackages = pkgs.linuxPackages_zen;

          # Use KDE Plasma 6
          services.desktopManager.plasma6.enable = true;

          # Temurin JRE
          environment.systemPackages = with pkgs; [
            temurin-jre-bin
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
