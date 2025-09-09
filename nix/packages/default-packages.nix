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
  ];

  startupPlugins = {
    general = with pkgs.vimPlugins; [
      (nvim-treesitter.withAllGrammars)
      nvim-lspconfig
      plenary-nvim
    ];
  };
}
