{inputs} : {
  flake.modules.nixos.defaultShell = {pkgs, ...}: {
    # Default all users to zsh
    users.defaultUserShell = pkgs.zsh;
  };
}