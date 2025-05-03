{ pkgs, lib, config, ... }:
let
  cfg = config.servers.vintage_story;
  runtime_opts = {
    tfm = "net8.0";
    framework_version = "8.0.0";
  };
  version = "1.20.9";
  fileHash = "sha256-a5Hk3xdOmXrfNgLVzA/OHdDrTTfPKqsyVpiMTbYXNHw=";
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

        buildInputs = [ pkgs.dotnet-runtime_8 ];

        nativeBuildInputs = [
          super.makeWrapper
        ];

        runtimeLibs = lib.makeLibraryPath (
          [
            # gtk2
            pkgs.sqlite
            # openal
            # cairo
            # libGLU
            # SDL2
            # freealut
            # libglvnd
            # pipewire
            # libpulseaudio
          ]
          # ++ (with xorg; [
          #   libX11
          #   libXi
          #   libXcursor
          # ])
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
            makeWrapper ${pkgs.dotnet-runtime_8}/bin/dotnet $out/bin/vintagestory-server \
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
