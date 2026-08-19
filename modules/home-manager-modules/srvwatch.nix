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

      services.srvwatch = {
        enable = true;

        # check_interval = {
        #   secs = 5;
        #   nanos = 0;
        # };

        # servers = {
        #   google = [
        #     { DNS = { hostname = "google.com"; }; }
        #     { Ping = { hostname = "thisisdefinitelynotgonnarespondright.com"; }; }
        #   ];
        #   localhost = [
        #     { Ping = { hostname = "127.0.0.1"; }; }
        #   ];
        # };
      };
    };
}
