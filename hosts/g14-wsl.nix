{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "warren";
}
