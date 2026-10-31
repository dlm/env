# env

My dotfiles. Plain config files, no nix required to use them: on another
machine, symlink a directory into `~/.config/` (or wherever the app looks).

On NixOS, Home Manager in the nixos repo (`~/repos/dlm/nixos`) links these
into place with `mkOutOfStoreSymlink`, so edits here take effect without a
rebuild. See `hosts/common/home.nix` and `modules/home/` there for what goes
where.

## Dev shell

`flake.nix` provides the tooling for editing this repo (`stylua`,
`lua-language-server` for the nvim config). With direnv, add an `.envrc`
containing `use flake` and run `direnv allow`.

## TODO

- zsh: still needed occasionally, but broken as written. `zshrc.local`
  expects zplug at `~/.zplug`, which isn't installed on the NixOS machines.
