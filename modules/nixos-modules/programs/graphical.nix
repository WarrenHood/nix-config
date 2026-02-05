{inputs, ...}: {
  flake.modules.nixos.graphicalPrograms = {pkgs, ...}: {
    # I'll almost always use the starship prompt
    programs.starship.enable = true;

    # Some basic packages that I will almost always use
    environment.systemPackages = with pkgs; [
      inputs.nixpkgs-stable.legacyPackages.${system}.firefox
      alacritty
      font-awesome
      polychromatic
      pavucontrol
      wdisplays
      wireplumber
      keepassxc
      thunar
      spotify

      # Partition management
      gparted

      # Steam controller
      sc-controller
    ];
  };
}
