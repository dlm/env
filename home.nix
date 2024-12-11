{ config, pkgs, ... }:

{
  home.username = "dave";
  home.homeDirectory = "/home/dave";
  home.stateVersion = "24.05";

  targets.genericLinux.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.fzf
    pkgs.ripgrep

    pkgs.atuin
    pkgs.zoxide
    pkgs.starship

    pkgs.neovim
    pkgs.tmux

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    # (pkgs.nerdfonts.override { fonts = [ "OpenDyslexic" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink /home/dave/repos/dlm/env/zsh/zshrc.local;
    "bin/scripts/".source = ./bin/scripts;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  xdg.configFile = {
    "nvim".source = config.lib.file.mkOutOfStoreSymlink /home/dave/repos/dlm/env/nvim;
    "tmux".source = config.lib.file.mkOutOfStoreSymlink /home/dave/repos/dlm/env/tmux;
    "zsh".source = ./zsh;
    "i3".source = ./i3;
    "rofi".source = ./rofi;
    "git".source = ./git;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dave/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
