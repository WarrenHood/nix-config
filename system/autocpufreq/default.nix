{ pkgs, ... }: {
   programs.auto-cpufreq.enable = true;

    programs.auto-cpufreq.settings = {
    charger = {
      governor = "performance";
      turbo = "never";
    };

    battery = {
      governor = "powersave";
      turbo = "never";
    };
  };
}