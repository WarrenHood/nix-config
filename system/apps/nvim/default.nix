{
  inputs,
  pkgs,
  ...
}:
inputs.nixvim.legacyPackages."${pkgs.stdenv.hostPlatform.system}".makeNixvimWithModule {
  inherit pkgs;
  module = {
    imports = [./options.nix ./plugins.nix ./autocmds.nix ./keybinds.nix];
    colorschemes.gruvbox.enable = true;
  };
}
