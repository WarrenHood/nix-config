# Common gaming stuff

user: { ... }: {
  imports = [
    (import ./gamemode.nix user)
    ./steam.nix
  ];

  powerManagement.cpuFreqGovernor = "performance";
}