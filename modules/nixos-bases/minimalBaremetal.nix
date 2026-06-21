# The minimal base system with networking and other useful things on baremetal
{
  inputs,
  self,
  ...
}: {
  flake.modules.nixos.minimalBaremetalBase = {pkgs, ...}: {
    imports = [
      self.modules.nixos.minimalNetworkedBase
    ];

    # I'll probably need a bootloader on baremetal. I'll use systemd-boot
    # We'll use systemd-boot for now...
    boot.loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = true;
    };

    # Use the newer dbus-broker implementation
    services.dbus.implementation = "broker";

    # Enable NTFS at boot
    boot.supportedFilesystems = ["ntfs"];

    # I'll try out tuned instead of power-profiles-daemon
    services.tuned.enable = true;

    # Battery stuff
    services.upower.enable = true;

    # Flatpak
    services.flatpak.enable = true;

    # Tailscale
    services.tailscale.enable = true;
    services.tailscale.useRoutingFeatures = "client";

    # Bluetooth
    services.blueman.enable = true;

    hardware.enableRedistributableFirmware = true; 

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          ControllerMode = "dual";
          FastConnectable = "true";
          Experimental = "true";
          KernelExperimental = "true";
        };
      };
    };
  };
}
