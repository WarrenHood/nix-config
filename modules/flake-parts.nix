{inputs, ...}: {
  # Allows the usage of flake-parts modules. See https://flake.parts/options/flake-parts-modules.html
  imports = [inputs.flake-parts.flakeModules.modules];
}
