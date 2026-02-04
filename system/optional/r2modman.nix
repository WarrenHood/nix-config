{
  pkgs,
  inputs,
  ...
}: let
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {environment.systemPackages = [pkgs-unstable.r2modman];}
