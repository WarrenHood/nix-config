{ inputs
, self
, ...
}: {
  flake.modules.homeManager.vscode =
    { pkgs
    , config
    , ...
    }: {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode;
        mutableExtensionsDir = false;
        profiles.default.extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace; [
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
        profiles.default.userSettings = {
          "workbench.colorTheme" = "Gruvbox Dark Medium";
          "telemetry.telemetryLevel" = "off";
          "python.languageServer" = "None";
          "editor.formatOnSave" = true;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.formatterPath" = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
          "nix.serverSettings" = {
            "nixd" = { formatting = { command = [ "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt" ]; }; };
          };
          "workbench.startupEditor" = "none";
          "editor.fontLigatures" = true;
          "editor.fontFamily" = "'JetBrainsMono Nerd Font'";
          "rust-analyzer.server.path" = "rust-analyzer";
        };
      };
    };
}
