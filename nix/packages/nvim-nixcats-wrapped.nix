{ inputs, lib, system, ... }:
let
  utils = inputs.nixCats.utils;
  nixpkgs = inputs.nixpkgs;
  luaPath = ../..; # nvim root (contains lua/ and config)

  # Include standard plugin overlay to expose pkgs.neovimPlugins from inputs.plugins-*
  dependencyOverlays = [ (utils.standardPluginOverlay inputs) ];
  extra_pkg_config = { };

  # Category and package definitions (minimal): runtime deps + basic settings
  categoryDefinitions =
    { pkgs, ... }:
    let
      runtimeDeps = with pkgs; [
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
    in
    {
      lspsAndRuntimeDeps.general = runtimeDeps;
      # Git plugins provided via inputs -> pkgs.neovimPlugins
      startupPlugins.gitPlugins = with pkgs.neovimPlugins; [
        fzf-lua
        fzf-lua-frecency
        monokai-v2
        gitsigns
      ];
      # Core plugins from nixpkgs (needed by your Lua config)
      startupPlugins.general = with pkgs.vimPlugins; [
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
      ];
    };

  packageDefinitions = {
    nvim = { pkgs, ... }: {
      settings = {
        suffix-path = true;
        suffix-LD = true;
        wrapRc = true;
        aliases = [ "vim" ];
        neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${system}.neovim;
      };
      categories = {
        general = true;
        gitPlugins = true;
      };
    };
  };

  # Build nixCats package and wrap it with our config
  nixCatsBuilder = utils.baseBuilder luaPath
    {
      inherit nixpkgs dependencyOverlays extra_pkg_config system;
    }
    categoryDefinitions
    packageDefinitions;

  nvimPkg = nixCatsBuilder "nvim";

  # Use wrapper-manager to add runtime site and flags
  fullPkgs = inputs.nixpkgs.legacyPackages.${system};
  wm = inputs.wrapper-manager.lib {
    pkgs = fullPkgs;
    inherit lib;
    modules = [
      {
        wrappers.nvim-nixcats = {
          basePackage = nvimPkg;
          # Ensure Neovim discovers plugins from nixCats' site dir and load our init.lua via -u
          extraWrapperFlags = "--prefix XDG_DATA_DIRS : ${nvimPkg}/share --add-flags -u --add-flags ${luaPath}/init.lua";
        };
      }
    ];
  };
in
wm.config.wrappers."nvim-nixcats".wrapped
