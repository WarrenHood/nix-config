# A minimal graphical base without a DE or compositor. Includes common graphical apps
{self, ...}: {
  flake.modules.nixos.minimalGraphicalBase = {pkgs, ...}: {
    imports = [
      self.modules.nixos.minimalBaremetalBase
      self.modules.nixos.graphicalPrograms
    ];

    fonts.packages = with pkgs; [
      # Stable NixOS 24.11 nerd fonts
      # (nerdfonts.override {fonts = ["Mononoki" "JetBrainsMono"];})

      # Might as well have noto fonts
      noto-fonts

      # Nerd fonts for nixos-unstable
      nerd-fonts.mononoki
      nerd-fonts.jetbrains-mono
    ];

    services.xserver.xkb.layout = "us";

    # xserver and sddm
    services.xserver.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      autoNumlock = true;
      # theme = "where_is_my_sddm_theme";
      settings = {Theme = {CursorTheme = "breeze_cursors";};};
    };

    # Enable pipewire service and rtkit
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # gnome-keyring
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.sddm.enableGnomeKeyring = true;
  };
}
