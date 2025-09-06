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

  # Use wrapper-manager to inject XDG config path and app name
  fullPkgs = inputs.nixpkgs.legacyPackages.${system};
  configLink = fullPkgs.linkFarm "xdg-config" { "nvim" = luaPath; };
  wm = inputs.wrapper-manager.lib {
    pkgs = fullPkgs;
    inherit lib;
    modules = [
      {
        wrappers.nvim-nixcats = {
          basePackage = nvimPkg;
          # Make sure Neovim sees the nixCats site under share/nvim/site
          extraWrapperFlags = "--prefix XDG_DATA_DIRS : ${nvimPkg}/share";
          env = {
            XDG_CONFIG_HOME = { value = configLink; force = true; };
            NVIM_APPNAME = { value = "nvim"; force = true; };
          };
        };
      }
    ];
  };
in
wm.config.wrappers."nvim-nixcats".wrapped
