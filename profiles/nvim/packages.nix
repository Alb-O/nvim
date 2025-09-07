{ pkgs, ... }:
{
  # Full-featured main profile packages
  runtimeDeps = with pkgs; [
    nixd
    lua-language-server
    vscode-json-languageserver
    ripgrep
    fzf
    lazygit
    pwgen
    zk
    rust-analyzer
    clippy
  ];

  startupPlugins = {
    general = (with pkgs.vimPlugins; [
      (nvim-treesitter.withAllGrammars)
      mini-nvim
      noice-nvim
      nui-nvim
      nvim-lspconfig
      lualine-nvim
      toggleterm-nvim
      sqlite-lua
      nvim-notify
      zk-nvim
      vim-fugitive
      plenary-nvim
    ]) ++ (with pkgs.vimPlugins; [ fzf-lua fzf-lua-frecency monokai-v2 gitsigns ]);
  };
}
