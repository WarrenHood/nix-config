aagl: { pkgs, ... }: {
  nix.settings = aagl.nixConfig; # Cachix
  # programs.anime-game-launcher.enable = true;
  programs.honkers-railway-launcher.enable = true;
  programs.sleepy-launcher.enable = true;
}