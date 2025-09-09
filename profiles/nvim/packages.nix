{ pkgs, ... }:
{
  # Full-featured main profile packages (defaults provide treesitter, lspconfig, plenary, language servers)
  runtimeDeps = with pkgs; [
    fzf
    lazygit
    pwgen
    zk
  ];

  startupPlugins = {
    general = with pkgs.vimPlugins; [
      mini-nvim
      noice-nvim
      nui-nvim
      lualine-nvim
      toggleterm-nvim
      sqlite-lua
      nvim-notify
      vim-fugitive
      fzf-lua
      fzf-lua-frecency
      monokai-v2
      gitsigns
      zk-nvim
    ];
  };
}
