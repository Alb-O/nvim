{ symlinkJoin, nvim-wrapped, inputs, lib, system }:
let
  profilesDir = ../../profiles;
  dirMap = builtins.readDir profilesDir;
  isDir = name: dirMap.${name} == "directory";
  allNames = builtins.attrNames dirMap;
  profileNames = builtins.filter isDir allNames;
  mkWrapper = name: import ./nvim-profile-wrapped.nix { inherit inputs lib system; profileName = name; };
  wrappers = map mkWrapper profileNames;
in
symlinkJoin {
  name = "nvim-tools";
  paths = [ ] ++ wrappers ++ [
    # Keep the plain wrapper last so it doesn't shadow the custom nvim
    nvim-wrapped
  ];
}
