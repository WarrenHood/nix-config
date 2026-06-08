{
  inputs,
  self,
  ...
}: {
  flake.modules.homeManager.cli = {
    pkgs,
    config,
    ...
  }: {
    home.packages = with pkgs; [
      nixd
      fastfetch
      tmux

      # archives
      zip
      xz
      unzip
      p7zip

      # utils
      ripgrep # recursively searches directories for a regex pattern
      jq # A lightweight and flexible command-line JSON processor
      eza # A modern replacement for ‘ls’
      fzf # A command-line fuzzy finder

      # Thermals and performance
      s-tui # stres test tui
      stress # stress testing

      # My minecraft package manager
      # mcmpmgr.packages.${system}.mcmpmgr
    ];
  };
}
