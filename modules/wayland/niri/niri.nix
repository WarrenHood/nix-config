{
  inputs,
  self,
  ...
}: {
  flake.modules.nixos.niri = {pkgs, ...}: {
    imports = with self.modules.nixos; [
      waylandBase
      inputs.niri.nixosModules.niri
    ];

    # Use niri-unstable since niri-stable is kinda behind
    programs.niri.package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;

    programs.niri.enable = true;

    # TODO: Is xwayland-satellite included by default when niri is enabled?
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
  };

  flake.modules.homeManager.niriConfig = {pkgs, ...}: {
    imports = with self.modules.homeManager; [
      waylandBase
    ];

    programs.niri.package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;

    # TODO: Migrate over to programs.niri.settings at some point
    programs.niri.config = builtins.readFile "${self}/dotfiles/niri/config.kdl";
  };

  flake.modules.homeManager.niriStandalone = {pkgs, ...}: {
    # Standalone niri home-manager module for my non-NixOS systems
    # TODO: On non-NixOS systems I need to figure out graphics...
    # at the moment, I just build niri from source and don't even use this module
    # but I will probably figure out the GPU issues and screensharing issues with this standalone module later

    imports = with self.modules.homeManager; [
      inputs.niri.homeModules.niri
      niriConfig
    ];

    # Enable niri
    programs.niri.enable = true;

    # Enable gnome xdg portals for screensharing on Wayland (discord etc)
    # TODO: Maybe I should just use the system installed xdg portals on non-nixos systems...
    # because this doesn't seem to work? Although it is also probably because of broken graphics...
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gnome];
    xdg.portal.config = {
      common = {
        default = ["gnome"];
      };
    };

    home.packages = with pkgs; [
      xwayland-satellite
    ];
  };
}
