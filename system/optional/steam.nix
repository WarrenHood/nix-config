{pkgs, ...}: {
  nixpkgs.config.packageOverrides = pkgs: {
    # Fix gamescope windows not showing on Hyprland
    # See https://github.com/ValveSoftware/gamescope/issues/905
    steam = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          libgdiplus
          keyutils
          libkrb5
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
        ];
    };
  };

  programs.steam = {enable = true;};

  # Controller support
  hardware.steam-hardware.enable = true;
}
