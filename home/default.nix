{ config, pkgs, user, ... }: {
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  imports = [
    ./vscode.nix
    ./direnv.nix
  ];

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

    # TODO: Get Breeze-Dark cursor working
    # cursorTheme = {
    #   name = "Breeze-Cursor";
    #   package = pkgs.libsForQt5.breeze-icons;
    # };

    # Prefer dark theme in GTK 3 and 4
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
