{ ... }: {
  imports = [
    ./bootloader # Bootloader
    ./users # Setup system users
    ./fonts # Setup fonts
    ./locale # Timezone and locale
    ./services # System services
    ./apps # Install system-wide apps and programs
    ./networking # Networking and firewall settings
    ./razer # Razer things
    ./autocpufreq # Automatic CPU Speed/Power Optimisation
  ];

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
}
