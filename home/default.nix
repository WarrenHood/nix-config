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

    gtk = {
      enable = true;
      theme = {
        name = "Breeze-Dark";
        package = pkgs.libsForQt5.breeze-gtk;
      };
      iconTheme = {
        name = "breeze-dark";
        package = pkgs.libsForQt5.breeze-icons;
      };
      cursorTheme = {
        name = "breeze";
        package = pkgs.libsForQt5.breeze-icons;
      };
      gtk3 = {
        extraConfig.gtk-application-prefer-dark-theme = true;
      };
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "breeze";
    package = pkgs.libsForQt5.breeze-icons;
    size = 16;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Breeze-Dark";
      color-scheme = "prefer-dark";
    };
  };


  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
