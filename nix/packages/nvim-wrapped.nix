{ inputs, lib, system, ... }@pkgs:
let
  fullPkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
  };
  luaPath = ../../.;
  wm = inputs.wrapper-manager.lib {
    pkgs = fullPkgs;
    inherit lib;
    modules = [
      {
        wrappers.nvim = {
          basePackage = fullPkgs.neovim;
          extraWrapperFlags = "--add-flags -u --add-flags ${luaPath}/init.lua";
        };
      }
    ];
  };
in
wm.config.wrappers.nvim.wrapped
