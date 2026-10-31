## Neovim config

Home Manager (in the nixos repo, `~/repos/dlm/nixos/hosts/common/home.nix`)
symlinks `~/.config/nvim` to this directory with `mkOutOfStoreSymlink`, so
edits take effect without a rebuild.

### Things this config expects from outside the repo

From the nixos repo (`~/repos/dlm/nixos`):

- `modules/home/neovim.nix`: neovim itself plus
  - `tree-sitter` CLI: treesitter parsers are built the first time a
    filetype is opened. Without it (or a C compiler, `gcc` below),
    highlighting silently stays regex-only.
  - `ripgrep` (telescope live grep), `git` (fugitive, gitsigns).
- `hosts/common/configuration.nix`: `gcc`, `lua-language-server`, `nixd`,
  `stylua` and `nixfmt` (formatters used by conform).

Per-project tools come from the project's devShell (direnv), e.g. `gopls`,
`rust-analyzer`, `goimports`. Servers are enabled in `lua/plugins/lsp.lua`
and skipped when the binary isn't on the PATH.

nixd reads NixOS options from the project's flake when it defines
`nixosConfigurations`, otherwise from `~/repos/dlm/nixos`. If that repo
moves, update `default_flake` in `lua/plugins/lsp.lua`.
