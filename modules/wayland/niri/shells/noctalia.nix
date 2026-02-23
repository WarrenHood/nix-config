{inputs, ...}: {
  flake.modules.homeManager.noctaliaShell = {...}: {
    imports = [
      # Noctalia shell home manager module
      inputs.noctalia.homeModules.default
    ];

    programs.niri.settings = {
      spawn-at-startup = [
        {argv = ["noctalia-shell"];}
      ];
    };

    # Enable noctalia shell
    programs.noctalia-shell = {
      enable = true;
    };
  };
}
