{...} : {
  flake.modules.nixos.g14-wsl = {
    imports = [
      # include NixOS-WSL modules
      <nixos-wsl/modules>
    ];

    wsl.enable = true;
    wsl.defaultUser = "warren";
  };
}