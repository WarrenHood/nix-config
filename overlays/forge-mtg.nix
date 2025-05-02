{ pkgs, lib, ... }:
let
  version = "1.6.64";
  forge_overlay = (self: super:
    let
      src = super.fetchurl {
        url =
          "https://github.com/Card-Forge/forge/releases/download/forge-${version}/forge-gui-desktop-${version}.tar.bz2";
        sha256 = "sha256-GqB79yAldbUIIq8Ui3bkymqd8DimQiZ0RtD2zPZ7t+E=";
      };
    in {
      forge-mtg = super.stdenv.mkDerivation {
        inherit src version;
        pname = "forge-mtg";

        nativeBuildInputs = [ pkgs.makeWrapper ];

        unpackPhase = ''
          tar -xvjf $src
        '';

        installPhase = ''
          runHook preInstall
          mkdir -p $out/bin $out/share/forge
          cp -a * $out/share/forge/
          runHook postInstall
        '';

        preFixup = ''
          for commandToInstall in forge forge-adventure forge-adventure-editor; do
            chmod 555 $out/share/forge/$commandToInstall.sh
            makeWrapper $out/share/forge/$commandToInstall.sh $out/bin/$commandToInstall \
              --prefix PATH : ${
                lib.makeBinPath [ pkgs.coreutils pkgs.openjdk pkgs.gnused ]
              } \
              --set JAVA_HOME ${pkgs.openjdk}/lib/openjdk \
              --set SENTRY_DSN ""
          done
        '';

        meta = with lib; {
          description = "Magic: the Gathering card game with rules enforcement";
          homepage = "https://www.slightlymagic.net/forum/viewforum.php?f=26";
          license = licenses.gpl3Plus;
          maintainers = with maintainers; [ eigengrau ];
        };
      };
    });
in { nixpkgs.overlays = [ forge_overlay ]; }
