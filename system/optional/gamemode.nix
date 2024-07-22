user: { ... }: {
  programs.gamemode.enable = true;
  users.users.${user}.extraGroups = ["gamemode"];
}