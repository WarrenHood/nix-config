{ inputs
, self
, ...
}: {
  flake.modules.homeManager.srvwatch =
    { pkgs
    , config
    , ...
    }: {
      imports = [ inputs.srvwatch.homeManagerModules.default ];

      services.srvwatch.enable = true;
    };
}
