{inputs, ...}: {
  flake.nixosModules.useZSH = {pkgs, ...}: {
    # Default all users to zsh
    users.defaultUserShell = pkgs.zsh;

    # Enable zsh
    programs.zsh.enable = true;
  };
}
