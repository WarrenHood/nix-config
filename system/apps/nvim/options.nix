{ ... }: {
  globalOpts = { };

  opts = {
    number = true;
    relativenumber = true;
    autoindent = true;

    tabstop = 4;
    shiftwidth = 4;
    softtabstop = 4;
    smartindent = true;
    expandtab = true;

    clipboard = "unnamedplus";

    ignorecase = true;
    smartcase = true;

    mouse = "a";

    termguicolors = true;

    timeoutlen = 500;
  };

  globals = {
    mapleader = " ";
    loaded_netrw = 1;
    loaded_netrwPlugin = 1;
  };

  extraFiles = {
    "after/ftplugin/nix.lua".text = ''
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 2
      vim.bo.expandtab = true
    '';
  };
}
