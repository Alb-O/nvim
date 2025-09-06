{ inputs, lib, system, ... }:
let
  fullPkgs = inputs.nixpkgs.legacyPackages.${system};
  # Base (prebuilt, autopatchelf'ed) goneovim package
  goneovimBase = import ./goneovim.nix { pkgs = fullPkgs; lib = fullPkgs.lib; };
  # Use the nixCats-built Neovim package to source plugins from its share/nvim/site
  nvimNixCats = import ./nvim-nixcats-wrapped.nix { inherit inputs lib system; };

  # XDG config directory that contains goneovim/settings.toml and Neovim config
  configLink = fullPkgs.linkFarm "xdg-config" {
    "goneovim" = ../../config/goneovim;
    "nvim" = ../..;
  };

  wm = inputs.wrapper-manager.lib {
    pkgs = fullPkgs;
    inherit lib;
    modules = [
      {
        wrappers.goneovim = {
          basePackage = goneovimBase;
          # Ensure Neovim can discover site/pack from nixCats
          extraWrapperFlags = "--prefix XDG_DATA_DIRS : ${nvimNixCats}/share";
          # Ensure the spawned Neovim comes from our nixCats build
          pathAdd = [ nvimNixCats ];
          env = {
            # Ensure both goneovim and Neovim read from our bundled configs
            XDG_CONFIG_HOME = { value = configLink; force = true; };
            NVIM_APPNAME = { value = "nvim"; force = true; };
          };
        };
      }
    ];
  };
in
wm.config.wrappers.goneovim.wrapped
