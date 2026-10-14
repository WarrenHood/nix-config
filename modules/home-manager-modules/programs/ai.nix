{ inputs, self, ... }: {
  flake.modules.homeManager.ai =
    { pkgs, ... }:
    let
      llama-cpp-kv-streaming =
        pkgs.llama-cpp-cuda.overrideAttrs (old: {
          src = pkgs.fetchFromGitHub {
            owner = "RaymondHuang210129";
            repo = "llama.cpp-adaptive-kv-streaming";
            rev = "1240f34c7";
            hash = "sha256-cNKfpanrj36qhFqEWmhhdWFp5tSnjmDC3+V0keP/jPY=";
          };

          # This upstream patch cannot apply for some reason so I'll ignore it
          patches = builtins.filter
            (patch:
              !(pkgs.lib.hasInfix
                "07ccce23cf7fe3c84e13d810accff672b1d966bf"
                (baseNameOf (toString patch))))
            (old.patches or [ ]);

          npmDepsHash = "sha256-hqYzdp1FwPhYkBP278fQXgY9NCKB6Q3P6Gko7BfP0m0=";

          cmakeFlags = (old.cmakeFlags or [ ]) ++ [
            "-DGGML_CUDA_FA_ALL_QUANTS=ON"
          ];

          doCheck = false;
        });

    in
    {
      nixpkgs.config.allowUnfree = true;

      home.packages = [
        llama-cpp-kv-streaming
        pkgs.pi-coding-agent
      ];
    };
}

