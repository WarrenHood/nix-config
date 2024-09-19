{ pkgs, ... }:
let
  krisp-patcher = pkgs.writers.writePython3Bin "krisp-patcher" {
    libraries = with pkgs.python3Packages; [ capstone pyelftools ];
    flakeIgnore = [
      "E501" # line too long (82 > 79 characters)
      "F403" # ‘from module import *’ used; unable to detect undefined names
      "F405" # name may be undefined, or defined from star imports: module
    ];
  } (builtins.readFile ./krisp-patcher.py);
in
{
  home.packages = [
    (pkgs.discord.override { withVencord = true; withTTS = true; })
    krisp-patcher # Need to patch ~/.config/discord/0.0.67/modules/discord_krisp/discord_krisp.node
  ];
}