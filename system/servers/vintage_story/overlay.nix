{ pkgs, lib, config, ... }:
let
  cfg = config.servers.vintage_story;
  runtime_opts = {
    tfm = cfg.net_tfm;
    framework_version = cfg.net_framework_version;
  };
  version = cfg.version;
  fileHash = cfg.server_hash;
  dotnet-runtime = cfg.dotnet_runtime_package;
  vintagestory_overlay = (self: super:
    let
      src = super.fetchurl {
        # We only need the server
        url = "https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${version}.tar.gz";
        hash = fileHash;
      };
    in
    {
      vintagestory = super.vintagestory.overrideAttrs rec {
        inherit src version;

        sourceRoot = ".";

        buildInputs = [ dotnet-runtime ];

        nativeBuildInputs = [
          super.makeWrapper
        ];

        runtimeLibs = lib.makeLibraryPath (
          [
            pkgs.sqlite
          ]
        );

        desktopItems = [ ];

        installPhase = ''
          runHook preInstall

          mkdir -p $out/share/vintagestory $out/bin $out/share/pixmaps
          echo "Current dir contents ($(pwd))"
          ls
          cp -r * $out/share/vintagestory
          # echo "Contents of $out/share/vintagestory"
          # ls $out/share/vintagestory
          # cp $out/share/vintagestory/assets/gameicon.xpm $out/share/pixmaps/vintagestory.xpm
          # cp $out/share/vintagestory/assets/game/fonts/*.ttf

          echo "Patching runtime config with tfm = \"${runtime_opts.tfm}\", framework version =  \"${runtime_opts.framework_version}\""
          ${pkgs.jq}/bin/jq '.runtimeOptions.tfm = "${runtime_opts.tfm}" | .runtimeOptions.framework.version = "${runtime_opts.framework_version}"' $out/share/vintagestory/VintagestoryServer.runtimeconfig.json > $out/share/vintagestory/tmpRuntimeConfig.json && mv $out/share/vintagestory/tmpRuntimeConfig.json $out/share/vintagestory/VintagestoryServer.runtimeconfig.json

          runHook postInstall
        '';

        preFixup =
          ''
            makeWrapper ${dotnet-runtime}/bin/dotnet $out/bin/vintagestory-server \
              --prefix LD_LIBRARY_PATH : "${runtimeLibs}" \
              --add-flags $out/share/vintagestory/VintagestoryServer.dll
          ''
          + ''
            find "$out/share/vintagestory/assets/" -not -path "*/fonts/*" -regex ".*/.*[A-Z].*" | while read -r file; do
              local filename="$(basename -- "$file")"
              ln -sf "$filename" "''${file%/*}"/"''${filename,,}"
            done
          '';
      };
    });
in
{ nixpkgs.overlays = lib.mkIf cfg.enable [ vintagestory_overlay ]; }
