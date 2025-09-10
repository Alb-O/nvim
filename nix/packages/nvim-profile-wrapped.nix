{ inputs, lib, system, profileName, ... }:
let
  luaPath = ../..;

  # Overlay to expose flake inputs (plugins-*) as pkgs.vimPlugins.<name>
  pluginOverlay = final: prev:
    let
      all = builtins.attrNames inputs;
      isPlugin = name: builtins.match "^plugins-.*" name != null;
      pluginNames = builtins.filter isPlugin all;
      toEntry = name:
        let short = builtins.replaceStrings [ "plugins-" ] [ "" ] name;
        in { name = short; value = prev.vimUtils.buildVimPlugin { pname = short; version = "unstable"; src = inputs.${name}; doCheck = false; }; };
      attrs = builtins.listToAttrs (map toEntry pluginNames);
    in { vimPlugins = prev.vimPlugins // attrs; };

  pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [ inputs.neovim-nightly-overlay.overlays.default pluginOverlay ];
  };

  # Load profile-specific packages and merge with defaults
  profilePkgFile = let p = "${luaPath}/profiles/${profileName}/packages.nix"; in if builtins.pathExists p then p else null;
  defaults = import "${luaPath}/nix/packages/common-packages.nix" { inherit pkgs; };
  specific = if profilePkgFile != null then import profilePkgFile { inherit pkgs; } else {};
  has = builtins.hasAttr;
  
  # Merge runtime dependencies (profile-specific ones come first to allow overriding)
  runtimeDeps = (if has "runtimeDeps" specific then specific.runtimeDeps else []) ++ defaults.runtimeDeps;
  
  # Merge startup plugins (profile-specific ones come first to allow overriding)
  startPlugins = (if has "startupPlugins" specific && has "general" specific.startupPlugins
                  then specific.startupPlugins.general else []) ++ defaults.startupPlugins.general;

  # Build a wrapped Neovim from the (nightly) unwrapped base with our plugins
  nvimPkg = pkgs.wrapNeovim pkgs.neovim-unwrapped {
    configure = {
      packages = { "${profileName}" = { start = startPlugins; }; };
    };
  };

  wrapperName = if profileName == "nvim" then "nvim" else "nvim-${profileName}";
  wm = inputs.wrapper-manager.lib {
    pkgs = pkgs;
    inherit lib;
    modules = [
      {
        wrappers.${wrapperName} = {
          basePackage = nvimPkg;
          extraWrapperFlags = "--add-flags -u --add-flags ${luaPath}/init.lua";
          pathAdd = runtimeDeps;
          env = { NVIM_PROFILE = { value = profileName; force = true; }; };
        };
      }
    ];
  };
in
let wrapped = wm.config.wrappers.${wrapperName}.wrapped;
in if wrapperName == "nvim" then wrapped else pkgs.runCommand "${wrapperName}" { } ''
  mkdir -p $out/bin
  ln -s ${wrapped}/bin/nvim $out/bin/${wrapperName}
''
