{pkgs, ...}: {

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
        mutableExtensionsDir = true;
        extensions = with pkgs.vscode-extensions; [
            # Git
            eamodio.gitlens

            # Theme
            jdinhlife.gruvbox
            pkief.material-icon-theme

            # Rust
            rust-lang.rust-analyzer
            tamasfe.even-better-toml
            serayuzgur.crates
            
            # Python
            ms-python.python
            ms-pyright.pyright
            ms-python.black-formatter

            # Nix
            jnoortheen.nix-ide

            # direnv for vscode. Mainly for nix shells
            mkhl.direnv
      ];
      userSettings = {
        "workbench.colorTheme" = "Gruvbox Dark Medium";
        "telemetry.telemetryLevel" = "off";
        "python.languageServer" = "None";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings" = {
            "nil" = {
                "diagnostics" = {
                    "ignored" = [
                        "unused_binding"
                        "unused_with"
                    ];
                };
                "formatting" = {
                    "command" = [
                        "nixpkgs-fmt"
                    ];
                };
            };
        };
        "workbench.startupEditor" = "none";
        "editor.fontLigatures" = true;
        "editor.fontFamily" = "'JetBrainsMono Nerd Font'";
      };
    };
}
