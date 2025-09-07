{ inputs, lib, system, ... }:
let
  fullPkgs = inputs.nixpkgs.legacyPackages.${system};
  # Base (prebuilt, autopatchelf'ed) goneovim package
  goneovimBase = import ./goneovim.nix { pkgs = fullPkgs; lib = fullPkgs.lib; };
  # Use the nixCats-built Neovim package to source plugins from its share/nvim/site
  nvimNixCats = import ./nvim-nixcats-wrapped.nix { inherit inputs lib system; };

  # XDG config directory for goneovim only (avoid overriding Neovim config)
  configLink = fullPkgs.linkFarm "xdg-config" { "goneovim" = ../../config/goneovim; };

  wm = inputs.wrapper-manager.lib {
    pkgs = fullPkgs;
    inherit lib;
    modules = [
      {
        wrappers.goneovim = {
          basePackage = goneovimBase;
          # Ensure Neovim can discover site/pack from nixCats
          extraWrapperFlags = "--prefix XDG_DATA_DIRS : ${nvimNixCats}/share";
          # Ensure the spawned Neovim comes from our nixCats build (with -u flags baked in)
          pathAdd = [ nvimNixCats ];
          env = {
            # Only set XDG for goneovim itself
            XDG_CONFIG_HOME = { value = configLink; force = true; };
          };
        };
      }
    ];
  };
in
wm.config.wrappers.goneovim.wrapped
