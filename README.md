# Neovim Flake with Profiles

This repository builds multiple Neovim binaries from a single codebase. Each binary uses a different config “profile” detected from the `profiles/` folder.

## Quick Start
- Build everything: `nix build -L .`
- Run one of the generated binaries in `result/bin`:
  - `nvim`        → profile `nvim`
  - `nvim-vanilla` → profile `vanilla`
  - `nvim-experiment` → profile `experiment`

## Profiles
- A profile is a directory under `profiles/<name>`.
- On build, each profile becomes a binary:
  - `profiles/nvim`       → `nvim`
  - `profiles/<name>`     → `nvim-<name>`
- Lua entrypoint: `profiles/<name>/init.lua` (loads your config for that profile).
- The root `init.lua` is a tiny bootstrap that adds this repo to `runtimepath` and loads the active profile.

## Per‑Profile Packages (Nix)
- Optional file: `profiles/<name>/packages.nix`
- Declares runtime tools and plugins for that profile only.
- Schema:
  ```nix
  { pkgs, ... }:
  {
    runtimeDeps = with pkgs; [
      # e.g. nixd ripgrep fzf lazygit
    ];

    startupPlugins = {
      # All plugins go here (from pkgs.vimPlugins and pkgs.neovimPlugins)
      general = (with pkgs.vimPlugins; [
        # e.g. nvim-lspconfig lualine-nvim mini-nvim
      ]) ++ (with pkgs.neovimPlugins; [
        # e.g. fzf-lua gitsigns
      ]);
    };
  }
  ```
- If `packages.nix` is missing, a minimal default is used (only `nvim-lspconfig` and basic LSP tools).

## Add/Remove a Profile
- Add:
  - `mkdir -p profiles/mysetup/lua`
  - Add `profiles/mysetup/init.lua` (your Lua config)
  - Optional: `profiles/mysetup/packages.nix` (plugins/tools)
  - `nix build -L .` → new binary `result/bin/nvim-mysetup`
- Remove:
  - `rm -r profiles/mysetup` and rebuild.

## Notes
- The active profile name is exported to Neovim as `NVIM_PROFILE`.
- Shared/global Lua (like `lua/lsp.lua` and the `lsp/` folder) remains available to all profiles.
- No plugin manager is used at runtime; plugins are provided by Nix.

