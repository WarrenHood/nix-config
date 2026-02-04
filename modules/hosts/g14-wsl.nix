{inputs, ...}: {
  flake.nixosConfigurations.g14-wsl = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.self.modules.nixos.commonSystemConfig # Common system configs
      inputs.self.modules.nixos.commonPrograms # Install common programs
      inputs.self.modules.nixos.warren # Warren user
      inputs.self.modules.nixos.useZSH # Use the default shell
      # Host specific config
      {
        imports = [
          # include NixOS-WSL modules
          <nixos-wsl/modules>
        ];

        networking.hostName = "g14-wsl";
        wsl.enable = true;
        wsl.defaultUser = "warren";
      }
    ];
  };
}
