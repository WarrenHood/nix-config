{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim # In case neovim ever breaks
    clang # For tree-sitter in Neovim
    neovim
    wget
    git
    htop
    ncdu
    stow
    gnumake
    neofetch
    fd
    ripgrep
    nil
    nixpkgs-fmt
    lshw

    # Partition management
    parted

    # Rust from rust-overlay
    # rust-bin.stable.latest.default

    # Aircrack-ng
    aircrack-ng
  ];
}
