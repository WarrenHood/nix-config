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
      ];
    };
  };
}
