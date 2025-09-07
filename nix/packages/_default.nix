{ symlinkJoin, nvim-wrapped, nvim-nixcats-wrapped, runtime-tools }:
symlinkJoin {
  name = "nvim-tools";
  paths = [
    # Ensure `nvim` in the bundle resolves to the nixCats build
    nvim-nixcats-wrapped
    runtime-tools
    # Keep the plain wrapper last so it doesn't shadow nixCats' nvim
    nvim-wrapped
  ];
}
