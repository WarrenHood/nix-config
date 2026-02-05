{...}: {
  flake.modules.nixos.useZSH = {pkgs, ...}: {
    # Default all users to zsh
    users.defaultUserShell = pkgs.zsh;

    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = ["git" "rust" "direnv"];
      };
    };
  };
}
