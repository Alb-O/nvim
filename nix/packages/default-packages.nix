{ pkgs, ... }:
{
  # Minimal, unopinionated baseline so new profiles don't pull in heavy stacks by default.
  runtimeDeps = with pkgs; [
    nixd
    lua-language-server
    vscode-json-languageserver
    ripgrep
  ];

  startupPlugins = {
    general = with pkgs.vimPlugins; [
      nvim-lspconfig
    ];
  };
}
