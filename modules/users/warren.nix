{inputs, ...}: {
  flake.nixosModules.warren = {pkgs, ...}: {
    users.users.warren = {
      isNormalUser = true;
      description = "Warren";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [];
    };
  };
}
