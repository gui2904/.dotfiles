{ config, pkgs, inputs, ... }:

{

  home.username = "clover";
  home.homeDirectory = "/home/clover";

  clover.programs = {
    zsh.enable = true;
    emacs.enable = true;
  };

  home.stateVersion = "24.05"; 

  home.packages = with pkgs; [
    python3
    go
    air
    vesktop
    direnv
    nodejs
    go-migrate
    goose
    sqlite
    tor
    ncmpcpp
    libreoffice
    feh
    alejandra
  ];

  # Foot
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Fira Code:size=11";
      }; 
    };
  };

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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
  #  /etc/profiles/per-user/clover/etc/profile.d/hm-session-vars.sh

  #gtk.enable = true;
  #qt.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
