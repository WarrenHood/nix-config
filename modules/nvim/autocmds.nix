{inputs, ...}: {
  flake.modules.nixvim.base = {
    autoCmd = [
      {
        # Format on save
        pattern = ["*.nix" "*.py" "*.rs" "*.toml" "*.json"];
        event = ["BufWritePre"];
        command = "lua vim.lsp.buf.format()";
      }
    ];
  };
}
