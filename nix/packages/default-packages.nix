{ pkgs, ... }:
{
  # Common baseline packages that all profiles should have
  runtimeDeps = with pkgs; [
    nixd
    lua-language-server
    vscode-json-languageserver
    ripgrep
    rust-analyzer
    clippy
    # Formatters for conform.nvim
    stylua
    nixfmt-rfc-style
    prettier
    rustfmt
  ];

  startupPlugins = {
    general = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      mini-icons
      nvim-lspconfig
      plenary-nvim
      conform-nvim
    ];
  };
}
