{pkgs, ...}: {
  # Nerd fonts
  fonts.packages = with pkgs; [
    # Stable NixOS 24.11 nerd fonts
    (nerdfonts.override {fonts = ["Mononoki" "JetBrainsMono"];})

    # Might as well have noto fonts
    noto-fonts

    # Nerd fonts for nixos-unstable
    # nerd-fonts.mononoki nerd-fonts.jetbrains-mono
  ];
}
