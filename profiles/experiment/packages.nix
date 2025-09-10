{ pkgs, ... }:
{
  # Experimental profile (defaults provide treesitter, lspconfig, plenary, language servers)
  runtimeDeps = with pkgs; [
    fzf
    lazygit
  ];
  startupPlugins = {
    general = with pkgs.vimPlugins; [
      hardtime-nvim
      which-key-nvim
      vscode-nvim
      gruvdark
      blink-cmp
      friendly-snippets
      indent-blankline-nvim
      fzf-lua
      fzf-lua-frecency
      videre
      alpha-nvim
      clipipe
    ];
  };
}
