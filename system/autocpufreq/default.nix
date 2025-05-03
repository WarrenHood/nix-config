{ pkgs, ... }: {
  # Need to disable power-profiles-daemon otherwise it conflicts with auto-cpufreq
  services.power-profiles-daemon.enable = false;

  programs.auto-cpufreq.enable = true;

  programs.auto-cpufreq.settings = {
    charger = {
      governor = "performance";

      # governor = "schedutil";
      # turbo = "never";
      # scaling_max_freq = 3600000;
    };

    battery = {
      governor = "powersave";
      turbo = "never";
    };
  };
}
