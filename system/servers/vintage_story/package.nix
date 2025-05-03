{ lib
, stdenv
, fetchurl
, makeWrapper
, sqlite
, jq
, cfg
}:
let
  runtime_opts = {
    tfm = cfg.net_tfm;
    framework_version = cfg.net_framework_version;
  };
  version = cfg.version;
  fileHash = cfg.server_hash;
  dotnet-runtime = cfg.dotnet_runtime_package;
in
stdenv.mkDerivation rec {
  pname = "vintagestoryserver";
  inherit version;
  src = fetchurl {
    # We only need the server
    url = "https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${version}.tar.gz";
    hash = fileHash;
  };

  sourceRoot = ".";

  nativeBuildInputs = [
    makeWrapper
  ];

  buildInputs = [ dotnet-runtime ];

  runtimeLibs = lib.makeLibraryPath (
    [
      sqlite
    ]
  );


  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/vintagestory $out/bin $out/share/pixmaps
    echo "Current dir contents ($(pwd))"
    ls
    cp -r * $out/share/vintagestory

    echo "Patching runtime config with tfm = \"${runtime_opts.tfm}\", framework version =  \"${runtime_opts.framework_version}\""
    ${jq}/bin/jq '.runtimeOptions.tfm = "${runtime_opts.tfm}" | .runtimeOptions.framework.version = "${runtime_opts.framework_version}"' $out/share/vintagestory/VintagestoryServer.runtimeconfig.json > $out/share/vintagestory/tmpRuntimeConfig.json && mv $out/share/vintagestory/tmpRuntimeConfig.json $out/share/vintagestory/VintagestoryServer.runtimeconfig.json

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
}
