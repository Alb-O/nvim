{ inputs, lib, system, ... }@pkgs:
let
  fullPkgs = inputs.nixpkgs.legacyPackages.${system};
  configLink = fullPkgs.linkFarm "xdg-config" {
    "nvim" = ../../.;
  };
  wm = inputs.wrapper-manager.lib {
    pkgs = fullPkgs;
    inherit lib;
    modules = [
      {
        wrappers.nvim = {
          basePackage = fullPkgs.neovim;
          env = {
            XDG_CONFIG_HOME = {
              value = configLink;
              force = true;
            };
            NVIM_APPNAME = {
              value = "nvim";
              force = true;
            };
          };
        };
      }
    ];
  };
in
wm.config.wrappers.nvim.wrapped
