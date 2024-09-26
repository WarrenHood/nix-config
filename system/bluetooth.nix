{ pkgs, inputs, system, ... }: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
    package = inputs.nixpkgs-stable.legacyPackages.${system}.bluez;
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
  boot.extraModprobeConfig = '' options bluetooth disable_ertm=1 ''; # Let my controller connect
}
