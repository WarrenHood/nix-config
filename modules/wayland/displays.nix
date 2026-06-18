{...}: {
  flake.modules.homeManager.waylandBase = {pkgs, ...}: {
    services.kanshi = {
      enable = true;

      settings = [
        {
          profile.name = "home-g14-with-external";
          profile.outputs = [
            # rog-g14 display
            {
              criteria = "Thermotrex Corporation TL140ADXP02-0 Unknown";
              mode = "2560x1600@165.002";
              position = "0,0";
              scale = 1.5;
            }

            # External monitor - home
            {
              criteria = "PNP(AOC) 24G2W1G4 ATNL61A180277";
              mode = "1920x1080@144.000";
              position = "1707,0";
            }
          ];
        }

        {
          profile.name = "home-g14-with-alienware";
          profile.outputs = [
            # rog-g14 display
            {
              criteria = "Thermotrex Corporation TL140ADXP02-0 Unknown";
              mode = "2560x1600@165.002";
              position = "0,0";
              scale = 1.5;
            }

            # External monitor - Alienware 1440p
            {
              criteria = "Dell Inc. AW2725DF JRS7ZZ3";
              mode = "2560x1440@144.00";
              position = "1707,0";
            }
          ];
        }
      ];
    };
  };
}
