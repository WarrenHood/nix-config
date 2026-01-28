{
  lib,
  pkgs,
  pkgs-unstable,
  inputs,
  system,
  ...
}: let
  callUnstablePackage = lib.callPackageWith pkgs-unstable;
in {
  environment.systemPackages = with pkgs; [
    vim # In case neovim ever breaks
    clang # For tree-sitter in Neovim
    # neovim
    (callUnstablePackage ./nvim {inherit inputs;})
    wget
    git
    htop
    ncdu
    stow
    gnumake
    neofetch
    fd
    ripgrep
    # nil
    # nixd
    # nixpkgs-fmt
    lshw

    # Partition management
    parted

    # Rust from rust-overlay
    # rust-bin.stable.latest.default

    # Aircrack-ng
    aircrack-ng

    # Java JRE LTS
    temurin-jre-bin

    p7zip

    tmux

    # inputs.mcmpmgr.packages.${system}.mcmpmgr
  ];
}
