{inputs, ...}: {
  flake.nixosConfigurations.g14-wsl = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.self.modules.nixos.commonSystemConfig # Common system configs
      inputs.self.modules.nixos.commonPrograms # Install common programs
      inputs.self.modules.nixos.g14-wsl # Host-specific config
      inputs.self.modules.nixos.warren # Warren user
      inputs.self.modules.nixos.useZSH # Use the default shell
    ];
  };
}
