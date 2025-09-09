{ pkgs, ... }:
{
  # Minimal profile (defaults provide treesitter, lspconfig, plenary, language servers)
  runtimeDeps = with pkgs; [ ];
  startupPlugins = {
    general = with pkgs.vimPlugins; [ 
      mini-nvim 
      lualine-nvim 
      toggleterm-nvim 
      nvim-notify 
      vim-fugitive 
      gitsigns 
    ];
  };
}
