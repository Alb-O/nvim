{ pkgs, ... }:
{
  # Example: keep vanilla minimal and add fugitive explicitly
  runtimeDeps = with pkgs; [ nixd lua-language-server ripgrep ];
  startupPlugins = {
    general = (with pkgs.vimPlugins; [ mini-nvim nvim-lspconfig lualine-nvim toggleterm-nvim nvim-notify vim-fugitive gitsigns ]);
  };
}
