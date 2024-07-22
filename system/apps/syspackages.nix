{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim # In case neovim ever breaks
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
    nil nixpkgs-fmt
    lshw
  ];
}
