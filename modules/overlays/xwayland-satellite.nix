# I'll remove this once https://github.com/Supreeeme/xwayland-satellite/issues/468 is merged
{ inputs
, ...
}:

let
  overlay = { pkgs, ... }: {
    nixpkgs.overlays = [
      (final: prev: {
        xwayland-satellite = (import inputs.nixpkgs-xwayland-satellite {
          system = pkgs.stdenv.hostPlatform.system;
        }).xwayland-satellite;
      })
    ];
  };
in
{
  flake.modules.nixos.xwaylandOverlay = overlay;
  flake.modules.homeManager.xwaylandOverlay = overlay;
}
