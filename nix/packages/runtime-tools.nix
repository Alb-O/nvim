{ pkgs, ... }:
pkgs.buildEnv {
  name = "runtime-tools";
  paths = with pkgs; [
    nixd
    lua-language-server
    vscode-json-languageserver
    rust-analyzer
    clippy
    ripgrep
    fzf
    lazygit
    pwgen
    zk
  ];
}

