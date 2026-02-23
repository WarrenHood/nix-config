{inputs, ...}: {
  flake.modules.homeManager.noctaliaShell = {...}: {
    imports = [
      # Noctalia shell home manager module
      inputs.noctalia.homeModules.default
    ];

    # TODO: Spawn noctalia at startup in niri config once I migrate it from kdl

    # Enable noctalia shell
    programs.noctalia-shell = {
      enable = true;
    };
  };
}
