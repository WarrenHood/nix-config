{inputs, ...}: {
  flake.nixosModules.commonPrograms = {pkgs, ...}: {
    # nix-ld to allow VS Code Remote to work for example
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages
    ];

    # I'll almost always use the starship prompt
    programs.starship.enable = true;

    # Some basic packages that I will almost always use
    environment.systemPackages = with pkgs; [
      vim # In case neovim ever breaks
      clang # For tree-sitter in Neovim
      wget
      git
      htop
      ncdu
      stow
      gnumake
      neofetch
      fd
      ripgrep
      lshw
      p7zip
      tmux
    ];
  };
}
