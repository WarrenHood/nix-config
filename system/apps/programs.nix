{ lib, pkgs, config, ... }:
with lib;
let cfg = config;
in {
  # Enable Hyprland
  programs.hyprland.enable = mkIf (!cfg.headless) true;
  programs.hyprland.xwayland.enable = mkIf (!cfg.headless) true;

  # Enable KDE Plasma 6
  # services.desktopManager.plasma6.enable = true;

  # Enable portals
  xdg.portal = mkIf (!cfg.headless) {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      # pkgs.xdg-desktop-portal-gnome
      # pkgs.xdg-desktop-portal-gtk
    ];
  };

  # I like zsh
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "rust" "direnv" ];
    };
  };

  # Enable starship prompt
  programs.starship.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
