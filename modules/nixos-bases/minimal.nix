{self, ...}: {
  flake.modules.nixos.minimalBase = {
    imports = [
      self.modules.nixos.commonSystemConfig # Common system configs
      self.modules.nixos.commonPrograms # Install common programs
      self.modules.nixos.warren # Warren user
      self.modules.nixos.useZSH # Use the default shell
    ];
  };
}
