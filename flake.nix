{
  description = "Neovim flake (flakelight style)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flakelight.url = "github:nix-community/flakelight";
    wrapper-manager.url = "github:viperML/wrapper-manager";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # Git plugin sources (bundled via nixCats standardPluginOverlay)
    plugins-fzf-lua-frecency = {
      url = "github:elanmed/fzf-lua-frecency.nvim";
      flake = false;
    };
    plugins-fzf-lua = {
      url = "github:ibhagwan/fzf-lua";
      flake = false;
    };
    plugins-zk-nvim = {
      url = "github:mickael-menu/zk-nvim";
      flake = false;
    };
    plugins-gitsigns = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    plugins-nvim-notify = {
      url = "github:rcarriga/nvim-notify";
      flake = false;
    };
    plugins-videre = {
      url = "github:Owen-Dechow/videre.nvim";
      flake = false;
    };
    plugins-clipipe = {
      url = "github:bkoropoff/clipipe";
      flake = false;
    };
    # Themes
    plugins-monokai-v2 = {
      url = "github:khoido2003/monokai-v2.nvim";
      flake = false;
    };
    plugins-gruvdark = {
      url = "github:darianmorat/gruvdark.nvim";
      flake = false;
    };
  };

  outputs =
    { flakelight, ... }@inputs:
    flakelight ./. {
      inherit inputs;
      # packages are auto-loaded from ./nix/packages
      devShell.packages =
        pkgs: with pkgs; [
          neovim
          git
          go
          gnumake
        ];
    };
}
