# set the aliases
alias v = nvim
alias l = ls
alias g = git
alias t = tmux-sessionizer

# set the editor
$env.buffer_editor = "nvim"
$env.EDITOR = "nvim"

# setup env management
$env.config.hooks.pre_prompt ++= [
    {||
        if (which direnv | is-empty) {
            return
        }

        direnv export json | from json | default {} | load-env
        if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
            $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
        }
    }
]

$env.config.edit_mode = 'vi'

$env.config.cursor_shape = {
    vi_insert: line
    vi_normal: block
    emacs: block
}

$env.config.keybindings ++= [
    {
        name: auto-complete-with-fzf
        modifier: control
        keycode: char_t
        mode: [emacs, vi_insert ]
        event: {
          send: executehostcommand,
          cmd: "commandline edit --append (fd --type f | fzf | str trim)"
        }
    }
]

# set the path
$env.PATH = [
    ($nu.home-path | path join "bin/scripts")
    ($nu.home-path | path join "bin/scripts-bky")
] ++ $env.PATH

# setup "plugins"
source ~/.local/share/nushell/vendor/plugins/starship.nu
source ~/.local/share/nushell/vendor/plugins/atuin.nu
source ~/.local/share/nushell/vendor/plugins/zoxide.nu
source ~/.local/share/nushell/vendor/plugins/carapace.nu


# Set the start banner
def show_banner [] {
    let ellie = [
        "     __  ,"
        " .--()°'.'"
        "'|, . ,'  "
        ' !_-(_\   '
    ]
    let s_mem = (sys mem)
    let s_ho = (sys host)
    print $"(ansi reset)(ansi green)($ellie.0)"
    print $"(ansi green)($ellie.1)  (ansi yellow) (ansi yellow_bold)Nushell (ansi reset)(ansi yellow)v(version | get version)(ansi reset)"
    print $"(ansi green)($ellie.2)  (ansi light_blue) (ansi light_blue_bold)RAM (ansi reset)(ansi light_blue)($s_mem.used) / ($s_mem.total)(ansi reset)"
    print $"(ansi green)($ellie.3)  (ansi light_purple)⏱ (ansi light_purple_bold)Uptime (ansi reset)(ansi light_purple)($s_ho.uptime)(ansi reset)"
}

$env.config.show_banner = false
if $nu.is-interactive {
    show_banner
}
