{ pkgs, inputs, ... }:
let pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in { environment.systemPackages = [ pkgs-unstable.r2modman ]; }
