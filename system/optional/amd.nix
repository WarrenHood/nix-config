{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # corectrl
    # radeon-profile
    amdctl
  ];
}
