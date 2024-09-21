{ pkgs, ... }: {
   programs.auto-cpufreq.enable = true;

    programs.auto-cpufreq.settings = {
    charger = {
      governor = "balance";
      turbo = "never";
    };

    battery = {
      governor = "powersave";
      turbo = "never";
    };
  };
}