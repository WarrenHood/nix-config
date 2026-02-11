{self, ...}: {
  flake.modules.nixos.minimalBase = {
    imports = with self.modules.nixos; [
      commonSystemConfig # Common system configs
      commonPrograms # Install common programs
      warren # Warren user
      useZSH # Use the default shell
      localeConfig # Configure locale
    ];
  };
}
