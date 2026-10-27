{ ... }: {
  flake.modules.nixos.ai = { pkgs, ... }: {
    users.users.warren.extraGroups = [
      "kvm"
    ];

    environment.systemPackages = with pkgs; [
      docker-sbx
    ];
  };
}
