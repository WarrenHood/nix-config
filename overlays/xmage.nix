{ pkgs, lib, ... }:
let
  version = "1.4.54-dev_2024-09-25_13-04";
  strVersion = "1.4.54";
  xmage_overlay = (self: super:
    let
      src = super.fetchurl {
        url = "http://xmage.today/files/mage-full_${version}.zip";
        sha256 = "sha256-ss4gU+gnopnwssGxQ/+o7Z1bPJmJQfheV++kHsfRxrQ=";
      };
    in
    {
      xmage = super.xmage.overrideAttrs {
        inherit src version;

        installPhase =
          ''
            mkdir -p $out/bin
            cp -rv ./* $out

            cat << EOS > $out/bin/xmage
            exec ${pkgs.jdk8}/bin/java -Xms256m -Xmx1024m -XX:MaxPermSize=384m -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -jar $out/xmage/mage-client/lib/mage-client-${strVersion}.jar
            EOS

            chmod +x $out/bin/xmage
          '';
      };
    });
in
{
  nixpkgs.overlays = [
    xmage_overlay
  ];
}
