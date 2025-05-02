{ inputs, lib, ... }: with lib; {
  imports = [
    ./bootloader # Bootloader
    ./users # Setup system users
    ./fonts # Setup fonts
    ./locale # Timezone and locale
    ./services # System services
    ./apps # Install system-wide apps and programs
    ./networking # Networking and firewall settings
    ./autocpufreq # Automatic CPU Speed/Power Optimisation
    ./bluetooth.nix # Enable bluetooth
  ];

  # Options
  options = {
      headless = mkEnableOption "Headless Mode";
  };

  # Configs
  config= {
      # Overlays
      nixpkgs.overlays = [
        # inputs.rust-overlay.overlays.default
      ];

      # cachix
      nix.settings = {
        substituters =
          [ "https://nix-community.cachix.org" "https://nix-gaming.cachix.org" ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        ];
      };

      # Enable all firmware I suppose
      # hardware.enableAllFirmware = true;

      # Enable flakes
      nix.settings.experimental-features = [ "nix-command" "flakes" ];

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "23.11"; # Did you read the comment?
  };
}
