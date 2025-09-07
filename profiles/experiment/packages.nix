{ pkgs, ... }:
{
  # Example: experiment adds Treesitter and UI stack explicitly (overrides defaults)
  runtimeDeps = with pkgs; [ nixd lua-language-server ripgrep fzf lazygit ];
  startupPlugins = {
    general = (with pkgs.vimPlugins; [
      hardtime-nvim
      vscode-nvim
      blink-cmp
      friendly-snippets
      indent-blankline-nvim
    ]);
  };
}
