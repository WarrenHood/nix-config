{ ... }: {
  plugins = {
    lualine.enable = true;
    web-devicons.enable = true;

    telescope = {
      enable = true;
      extensions = { fzf-native = { enable = true; }; };
    };

    nix = { enable = true; };

    lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        nixd = {
          enable = true;
          settings = { formatting = { command = [ "nixpkgs-fmt" ]; }; };
        };
        pyright.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
      };
    };

    # Completions
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        mapping = {
          "<C-d>" = # Lua
            "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = # Lua
            "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = # Lua
            "cmp.mapping.complete()";
          "<C-e>" = # Lua
            "cmp.mapping.close()";
          "<Tab>" = # Lua
            "cmp.mapping(cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}), {'i', 's'})";
          "<S-Tab>" = # Lua
            "cmp.mapping(cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}), {'i', 's'})";
          "<CR>" = # Lua
            "cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })";
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
          { name = "cmdline"; }
        ];
      };
    };

    # Neotree
    neo-tree = {
      enable = true;
      enableDiagnostics = true;
      enableGitStatus = true;
      enableModifiedMarkers = true;
      enableRefreshOnWrite = true;
      closeIfLastWindow = true;
      popupBorderStyle = "rounded";
      buffers = {
        bindToCwd = false;
        followCurrentFile = { enabled = true; };
      };
      window = {
        width = 40;
        height = 15;
        autoExpandWidth = false;
        mappings = {
          "<space>" = "none";
          "P" = {
            command = "toggle_preview";
            config = { use_float = true; };
          };
        };
      };
    };
  };
}
