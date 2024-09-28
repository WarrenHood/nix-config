# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];

  # Use the xanmod kernel
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.kernelModules = [ "kvm-amd" "hid_nintendo" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ ];
  boot.kernelParams = [
    # Disable amd pstate to stop stupid boosting my cpu temp through the roof
    # "initcall_blacklist=amd_pstate_init"
    # "amd_pstate.enable=0"
    
    # (Maybe) make bluetooth reconnections work without needing to restart bluetooth service
    # "btusb.enable_autosuspend=n"
    # "usbcore.autosuspend=-1"
  ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/dfe5cdc6-62b7-4ef0-aa0c-e38f4b4c6b24";
      fsType = "ext4";
    };
  
  fileSystems."/games" =
    { device = "/dev/disk/by-uuid/5536ab49-58e5-4de0-b017-be95b1c440f3";
      fsType = "ext4";
      options = [ "defaults" "users" "exec" "nofail" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/40F1-396F";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };


  # Star citizen requirements
  boot.kernel.sysctl = {
    # "vm.max_map_count" = 16777216; # Already set in platformOptimisations
    "fs.file-max" = 524288;
  };
  # See RAM, ZRAM & Swap
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;  # 8 GB Swap
  }];

  zramSwap = {
    enable = true;
    memoryMax = 16 * 1024 * 1024 * 1024;  # 16 GB ZRAM
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
