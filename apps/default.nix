{pkgs, ...} : {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    clang # For tree-sitter in Neovim
    neovim
    wget
    firefox
    alacritty
    wofi
    git
    stow
    gnumake
    waybar
    kitty
    font-awesome
    openrazer-daemon # Most people use Razer keyboards and mice... Right?
    polychromatic
    pavucontrol
    wdisplays
    wireplumber
    rustup # TODO: Figure out how to automatically run rustup default stable
    discord
    neofetch
    grim slurp swappy wl-clipboard # Screenshots in wayland
    spotify
    hyprpaper # Set wallpapers on Hyprland
    fd
    ripgrep
  ];
}
