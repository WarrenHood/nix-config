{ pkgs, ... }: {
   programs.auto-cpufreq.enable = true;

    programs.auto-cpufreq.settings = {
    charger = {
      governor = "schedutil";
      # turbo = "never";
      # scaling_max_freq = 3600000;
    };

    battery = {
      governor = "powersave";
      turbo = "never";
    };
  };
}