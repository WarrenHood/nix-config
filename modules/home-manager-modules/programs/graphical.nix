{
  inputs,
  self,
  ...
}: {
  flake.modules.homeManager.graphical = {
    pkgs,
    config,
    ...
  }: {
    home.packages = with pkgs; [
      # stremio
      polychromatic

      ## Games and launchers
      # heroic # Epic games
      # osu-lazer-bin

      # MTG things
      # cockatrice
      # forge-mtg
      # xmage

      # Godot
      # godot_4

      # Blender
      # blender

      # Pipewire easyeffects
      easyeffects

      # Reading
      # calibre

      # Torrenting
      # qbittorrent

      # Free Open Source YT client
      # freetube

      # Nexus mods app
      # nexusmods-app-unfree

      # Final Fantasy 14 Launcher
      # xivlauncher

      # Vintage story
      # pkgs-unfree.vintagestory
    ];
  };
}
