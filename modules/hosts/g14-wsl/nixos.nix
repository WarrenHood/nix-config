{inputs, ...}: {
  flake.nixosConfigurations.g14-wsl = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.self.nixosModules.commonSystemConfig # Common system configs
      inputs.self.nixosModules.commonPrograms # Install common programs
      inputs.self.nixosModules.g14-wsl # Host-specific config
      inputs.self.nixosModules.warren # Warren user
      inputs.self.nixosModules.useZSH # Use the default shell
    ];
  };
}
