{ pkgs, ... }:
{
  # Common baseline packages that all profiles should have
  runtimeDeps = with pkgs; [
    # Language Servers
    nixd
    lua-language-server
    vscode-json-languageserver
    rust-analyzer
    typescript-language-server
    biome
    yaml-language-server
    vscode-langservers-extracted # provides cssls, html, jsonls
    pyright
    nodePackages.bash-language-server
    ripgrep
    clippy

    # Formatters for conform.nvim
    stylua
    nixfmt-rfc-style
    prettier
    rustfmt
    biome
    ruff
    yamlfmt
    taplo
    shfmt
    go # provides gofmt and goimports
    sqlfluff
    libxml2 # provides xmllint
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
