# Common gaming stuff

user: { ... }: {
  imports = [
    (import ./gamemode.nix user)
    ./steam.nix
    ./r2modman.nix
  ];
}