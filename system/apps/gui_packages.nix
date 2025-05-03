# These are packages that would be installed on a non headless system
{ pkgs, system, inputs, config, lib, ... }: {
  environment.systemPackages = with pkgs;
    lib.mkIf (!config.headless) [
      inputs.nixpkgs-stable.legacyPackages.${system}.firefox
      alacritty
      wofi
      waybar
      kitty
      font-awesome
      polychromatic
      pavucontrol
      wdisplays
      wireplumber
      grim
      slurp
      swappy
      wl-clipboard # Screenshots in wayland
      spotify
      hyprpaper # Set wallpapers on Hyprland
      keepassxc
      xfce.thunar
      # Breeze Theme
      pkgs.libsForQt5.breeze-gtk
      pkgs.libsForQt5.breeze-icons
      # SDDM Theme
      (pkgs.where-is-my-sddm-theme.override {
        themeConfig.General = {
          background =
            "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          backgroundMode = "none";
        };
      })

      # Partition management
      gparted

      # Steam controller
      sc-controller
    ];
}
