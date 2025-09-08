{ pkgs, ... }:
{
  # Example: experiment adds Treesitter and UI stack explicitly (overrides defaults)
  runtimeDeps = with pkgs; [ nixd lua-language-server ripgrep fzf lazygit ];
  startupPlugins = {
    general = (with pkgs.vimPlugins; [
      hardtime-nvim
      which-key-nvim
      vscode-nvim
      gruvdark
      blink-cmp
      friendly-snippets
      indent-blankline-nvim
      dashboard-nvim
      fzf-lua
      fzf-lua-frecency
    ]);
  };
}
