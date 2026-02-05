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
      efi.canTouchEfiVariables = true;
    };

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
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
      package = inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.bluez;
      settings = {
        Policy.AutoEnable = "true";
        General = {
          Enable = "Source,Sink,Media,Socket";
          ControllerMode = "bredr";
          FastConnectable = "true";
          Experimental = "true";
          KernelExperimental = "true";
        };
      };
    };
    boot.extraModprobeConfig = "options bluetooth disable_ertm=1 "; # Let my controller connect
  };
}
