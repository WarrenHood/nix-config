{ pkgs, ... }: {
  # Nerd fonts
  fonts.packages = with pkgs; [
    nerd-fonts.mononoki nerd-fonts.jetbrains-mono
  ];
}
