{ 
  config, 
  pkgs, 
  lib, 
  ... 
}: let
  cfg = config.clover.programs.zsh;
in {
  options.clover.programs.zsh = {
    enable = lib.mkEnableOption "zsh";
    enableLsColors = true;  # Directly enable LS colors for zsh
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.nix-zsh-completions
    ];

  programs.carapace = lib.mkIf cfg.carapace.enable {
    enable = lib.mkDefault true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    zprof.enable = false;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      tree = "eza --tree --icons";
      emacs = "emacsclient -nc -a 'helix'";
    };

    history = {
      expireDuplicatesFirst = true;
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      append = true;
    };

    initExtra = ''
        zmodload zsh/complist

        function parse_git_branch() {
          git branch 2>/dev/null | sed -n '/\*/s/\* \(.*\)/ (\1)/p'
        }

        autoload -U colors && colors

        PS1="%B%{$fg[red]%}[%{$fg[#A020F0]%}%n%{$fg[magenta]%}@%{$fg[magenta]%}%M %{$fg[#A020F0]%}%~%{$fg[#A020F0]%}$(parse_git_branch)%{$fg[reset]%}]%{$reset_color%}$%b "
      '';
  };
}
