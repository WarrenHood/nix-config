{ pkgs, inputs, system, ... }: {

  nixpkgs.overlays = [
    (final: prev: {
      python3 = prev.python3.override {
        packageOverrides = pfinal: pprev: {
          debugpy = pprev.debugpy.overrideAttrs (oldAttrs: {
            pytestCheckPhase = "true";
          });
        };
      };
      python3Packages = final.python3.pkgs;
    })
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    mutableExtensionsDir = false;
    extensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
      # Git
      eamodio.gitlens

      # Theme
      jdinhlife.gruvbox
      pkief.material-icon-theme

      # Rust
      rust-lang.rust-analyzer
      tamasfe.even-better-toml

      # Python
      ms-python.python
      ms-pyright.pyright
      ms-python.black-formatter

      # Nix
      jnoortheen.nix-ide

      # direnv for vscode. Mainly for nix shells
      mkhl.direnv

      # Lua
      sumneko.lua
    ];
    userSettings = {
      "workbench.colorTheme" = "Gruvbox Dark Medium";
      "telemetry.telemetryLevel" = "off";
      "python.languageServer" = "None";
      "editor.formatOnSave" = true;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        "nixd" = {
          formatting = {
            command = [ "nixpkgs-fmt" ];
          };
        };
        # "nil" = {
        #   "diagnostics" = {
        #     "ignored" = [
        #       "unused_binding"
        #       "unused_with"
        #     ];
        #   };
        #   "formatting" = {
        #     "command" = [
        #       "nixpkgs-fmt"
        #     ];
        #   };
        # };
      };
      "workbench.startupEditor" = "none";
      "editor.fontLigatures" = true;
      "editor.fontFamily" = "'JetBrainsMono Nerd Font'";
      "rust-analyzer.server.path" = "rust-analyzer";
    };
  };
}
