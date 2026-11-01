# env

My dotfiles. Plain config files, no nix required to use them: on another
machine, symlink a directory into `~/.config/` (or wherever the app looks).

On NixOS, Home Manager in the nixos repo (`~/repos/dlm/nixos`) links these
into place with `mkOutOfStoreSymlink`, so edits here take effect without a
rebuild. See `hosts/common/home.nix` and `modules/home/` there for what goes
where.

## Shared assets

Files used by more than one app live in their own directory rather than
under any one app. Right now that's `wallpaper/`, linked to
`~/.config/wallpaper`: `current` points at the image in use, read by feh
(i3) and swaybg (niri).

Only things my own session reads can live here. Anything read by a system
service or another user (e.g. the lightdm greeter, which runs as `lightdm`)
can't follow a symlink into my home directory, and a pure flake can't copy
files from this repo into the store, so those assets belong in the nixos
repo instead.

## Dev shell

`flake.nix` provides the tooling for editing this repo (`stylua`,
`lua-language-server` for the nvim config). With direnv, add an `.envrc`
containing `use flake` and run `direnv allow`.

## zsh

Plugins are managed by [zplug](https://github.com/zplug/zplug). On NixOS it's
installed by the nixos repo; elsewhere, clone it to `~/.zplug`. On first
start zsh offers to install any missing plugins.
