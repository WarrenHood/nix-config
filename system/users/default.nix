{pkgs, ...}: {
  # Default all users to zsh
  users.defaultUserShell = pkgs.zsh;

  users.users.warren = {
    isNormalUser = true;
    description = "Warren";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
