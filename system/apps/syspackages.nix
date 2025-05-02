{ pkgs, system, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    vim # In case neovim ever breaks
    clang # For tree-sitter in Neovim
    neovim
    wget
    inputs.nixpkgs-stable.legacyPackages.${system}.firefox
    alacritty
    wofi
    git
    htop
    ncdu
    stow
    gnumake
    waybar
    kitty
    font-awesome
    polychromatic
    pavucontrol
    wdisplays
    wireplumber
    neofetch
    grim
    slurp
    swappy
    wl-clipboard # Screenshots in wayland
    spotify
    hyprpaper # Set wallpapers on Hyprland
    fd
    ripgrep
    nil
    nixpkgs-fmt
    lshw
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
    parted
    gparted

    # Steam controller
    sc-controller

    # Rust from rust-overlay
    # rust-bin.stable.latest.default

    # Aircrack-ng
    aircrack-ng
  ];
}
