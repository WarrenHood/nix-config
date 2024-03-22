{ config, pkgs, user, ... }: {
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

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

  # Set GTK theme to Breeze-Dark
  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
