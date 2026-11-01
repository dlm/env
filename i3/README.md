# i3

This is my i3 configuration.  A constant work in progress, but it continues to
work well for me.

The nixos repo links this directory to `~/.config/i3` and installs i3 and its
tools through `stacks.desktop.i3`.

- `config` — the i3 config. Most app launching goes through
  `~/.local/bin/launch` (`env/bin/scripts/launch`), so bindings name a
  concept ("terminal", "browser", "screenshot") rather than a program.
- `status` — i3status config for the bar.
- `bin/` — i3-only helpers: `i3-mode` (modes with a nagbar hint),
  `command-palette` and `muxwm-i3` (muxwm integration), `lock`, and moving
  workspaces between monitors. Scripts shared with niri (volume,
  brightness) live in `env/bin/scripts`.
- `assets/` — the icon `lock` overlays on the lock screen.

#  Enhancement Exploration List

The Enhancement Exploration List is an ever growing list of things that I want
to explore.  Some I have already tried, didn't like but want to try again.
Other are new ideas I've never tried before.  Either way, I'm always open to
suggestions.

1. Smart terminal spawning - Mod+Return opens new kitty in current directory of focused terminal
2. Picom compositor - Transparency, shadows, animations for modern look
3. Polybar status bar - More customizable than i3status with better visuals
4. Scratchpad workflows - Quick-access floating windows (terminal, notes,
   etc.), beyond the single scratchpad on `$mod+'` / `$mod+Shift+'`
5. Autotiling script - Automatic split direction based on window size
6. Screenshot improvements - Flameshot for annotations and better UX than the
   current scrot region-to-clipboard
7. Lockscreen customization - i3lock-color with custom images/effects
   (`bin/lock` currently pixelates the screen and overlays an icon)
8. Workspace-specific layouts - Auto-restore window layouts per workspace
9. Named scratchpads - Multiple scratchpads for different purposes
