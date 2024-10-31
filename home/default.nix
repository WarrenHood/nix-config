{ config, pkgs, user, mcmpmgr, system, ... }: {
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  imports = [
    ./vscode.nix
    ./direnv.nix
    ./star-citizen.nix
    ./discord
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch

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
    mission-center # A nice task-manager like thing

    # modrinth-app # Modrinth app for minecraft
    prismlauncher # Prism launcher for when modrinth is broken
    zulu17 # java 17

    # Thermals and performance
    s-tui # stres test tui
    stress # stress testing

    # My minecraft package manager
    mcmpmgr.packages.${system}.mcmpmgr

    stremio
    polychromatic

    ## Games and launchers
    heroic # Epic games
    osu-lazer-bin

    # MTG things
    cockatrice
    forge-mtg
    xmage

    # Godot
    godot_4

    # Pipewire easyeffects
    easyeffects
  ];

  # TODO: Uncomment this once home manager stops failing to replace /home/warren/.gtkrc-2.0
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Breeze-Dark";
  #     package = pkgs.libsForQt5.breeze-gtk;
  #   };
  #   iconTheme = {
  #     name = "breeze-dark";
  #     package = pkgs.libsForQt5.breeze-icons;
  #   };
  #   cursorTheme = {
  #     name = "breeze_cursors";
  #     package = pkgs.libsForQt5.breeze-icons;
  #   };
  #   gtk3 = {
  #     extraConfig.gtk-application-prefer-dark-theme = true;
  #   };
  # };

  home.pointerCursor = {
    # gtk.enable = true;
    name = "breeze_cursors";
    package = pkgs.libsForQt5.breeze-icons;
    size = 16;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Breeze-Dark";
      color-scheme = "prefer-dark";
    };
  };

  # Bluetooth applet
  services.blueman-applet.enable = true;


  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
