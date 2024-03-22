{ config, pkgs, ... }: {
  # TODO: Pass through username from flake
  home.username = "warren";
  home.homeDirectory = "/home/warren";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch
    nnn # terminal file manager

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
  ];


  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
