{inputs, ...}: {
  flake.modules.nixos.warren = {pkgs, ...}: {
    users.users.warren = {
      isNormalUser = true;
      description = "Warren";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [];
    };
  };
}
