{inputs, ...}: {
  flake.modules.nixvim.base = let
    defineGroup = k: desc: {
      key = k;
      action = "";
      options.desc = desc;
    };
  in {
    keymaps = [
      # Save and exit
      {
        key = "<C-q>";
        action = "<cmd>wq<cr>";
      }
      {
        mode = "i";
        key = "<C-q>";
        action = "<esc><cmd>wq<cr>";
      }

      # Save
      {
        key = "<C-s>";
        action = "<cmd>w<cr>";
      }
      {
        mode = "i";
        key = "<C-s>";
        action = "<esc><cmd>w<cr>";
      }

      # Neotree
      {
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
      }

      # Telescope
      (defineGroup "<leader>f" "Find with Telescope")
      {
        key = "<leader>fw";
        action = "<cmd>Telescope live_grep<cr>";
      }
      {
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
      }
      {
        key = "<leader>fg";
        action = "<cmd>Telescope git_commits<cr>";
      }
      {
        key = "<leader>fh";
        action = "<cmd>Telescope oldfiles<cr>";
      }
      (defineGroup "<leader>c" "Colorscheme")
      {
        key = "<leader>ch";
        action = "<cmd>Telescope colorscheme<cr>";
      }
      {
        key = "<leader>fm";
        action = "<cmd>Telescope man_pages<cr>";
      }

      # Code actions/quick fixes with ctrl + .
      {
        key = "<c-.>";
        action = "<cmd>lua vim.lsp.buf.code_action({ apply = true })<cr>";
      }

      # Show diagnostics
      {
        key = "<leader>E";
        action = "<cmd>lua vim.diagnostic.open_float()<cr>";
        options.desc = "Show diagnostics";
      }
    ];
  };
}
