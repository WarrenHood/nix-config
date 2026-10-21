{ inputs
, self
, ...
}: {
  flake.modules.homeManager._3d =
    { pkgs
    , ...
    }: {
      home.packages = with pkgs; [
        blender
        freecad
        (pkgs.symlinkJoin {
          name = "orca-slicer-wrapped";
          paths = [ pkgs.orca-slicer ];
          nativeBuildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/orca-slicer \
              --set WEBKIT_DISABLE_DMABUF_RENDERER "1"
          '';
        })
      ];
    };
}
