{ ... }: {
  flake.modules.nixos.useFish = { pkgs, ... }: {
    # Default all users to fish
    users.defaultUserShell = pkgs.fish;

    programs.fish = {
      enable = true;
      interactiveShellInit = "set fish_greeting";
    };
  };
}
