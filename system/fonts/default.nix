{pkgs, ...}: {
  # Mononoki Nerd Font
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Mononoki" "JetBrainsMono"]; })
  ];
}
