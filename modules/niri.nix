{
  inputs,
  self,
  ...
}: {
  flake.modules.nixos.niri = {pkgs, ...}: {
    imports = [
      inputs.niri.nixosModules.niri
    ];

    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];

    environment.variables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  flake.modules.homeManager.niriConfig = {pkgs, ...}: {
    imports = [
      # Noctalia shell home manager module
      inputs.noctalia.homeModules.default
    ];

    programs.niri.package = pkgs.niri;
    programs.fuzzel.enable = true;
    programs.niri.config = builtins.readFile "${self}/dotfiles/niri/config.kdl";

    # Enable noctalia shell
    programs.noctalia-shell = {
      enable = true;
    };
  };

  flake.modules.homeManager.niriStandalone = {pkgs, ...}: {
    imports = with self.modules.homeManager; [
      # Standalone niri home-manager module
      inputs.niri.homeModules.niri
      niriConfig
    ];

    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    home.packages = with pkgs; [
      xwayland-satellite
    ];

    # Enable niri
    programs.niri.enable = true;
  };
}
