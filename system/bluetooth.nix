{ ... }: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        AutoEnable = true;
        ControllerMode = "bredr";
      };
    };
  };
  boot.extraModprobeConfig = '' options bluetooth disable_ertm=1 ''; # Let my controller connect
}
