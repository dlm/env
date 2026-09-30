# set the aliases
alias v = nvim
alias l = ls
alias g = git
alias t = tmux-sessionizer
alias jl = journal edit
alias jp = nvim $"($env.home)/sync/notes/byte-binder/projects.md"
alias ? = ask claude

# simple functions
def nr [package: string] { nix run $"nixpkgs#($package)" }

# set the editor
$env.buffer_editor = "nvim"
$env.EDITOR = "nvim"
$env.SOPS_EDITOR = "nvim -u NONE -n --cmd 'set noswapfile noundofile nobackup nowritebackup shadafile=NONE nomodeline secure'"

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

# set the history management
$env.config.history = {
    file_format: "sqlite"
    isolation: true
}

# set the path
$env.PATH = [
    ($nu.home-path | path join "bin/scripts")
    ($nu.home-path | path join "bin/scripts-bky")
] ++ $env.PATH

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

# Wrap the external completer so that we return a null instead of an
# empty list, which makes nushell produce file system based completions.
let base_completer = $env.config.completions.external.completer
$env.config.completions.external.completer = {|spans|
    do $base_completer $spans | if ($in | is-not-empty) { $in }
}
