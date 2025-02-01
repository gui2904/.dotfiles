{ 
  config, 
  pkgs, 
  lib, 
  ... 
}: let
  cfg = config.clover.programs.zsh;
in {
  options.clover.programs.zsh = {
    enable = lib.mkEnableOption "enable zsh";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.nix-zsh-completions
    ];

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
        ls = "eza --icons";
      };
      sessionVariables = {
        EDITOR = "vim";
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=8,bg=white,bold,underline";
        HYPRSHOT_DIR = "~/Pictures/Screenshots";
      };

      history = {
        expireDuplicatesFirst = true;
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
        append = true;
      };

      initExtra = ''
        autoload -U colors && colors
        autoload -Uz add-zsh-hook

        # Syntax highlighting custom color styles
        ZSH_HIGHLIGHT_STYLES[command]='fg=green'
        ZSH_HIGHLIGHT_STYLES[argument]='fg=yellow'
        ZSH_HIGHLIGHT_STYLES[variable]='fg=cyan'
        ZSH_HIGHLIGHT_STYLES[default]='fg=white'  # Adjust this to your preference

        # Movement bindings
        bindkey -v
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word

        function parse_git_branch() {
          git branch 2>/dev/null | sed -n '/\*/s/\* \(.*\)/ (\1)/p'
        }
        PS1="%B%{$fg[red]%}[%{$fg[#A020F0]%}%n%{$fg[magenta]%}@%{$fg[magenta]%}%M %{$fg[#A020F0]%}%~%{$fg[#A020F0]%}$(parse_git_branch)%{$fg[reset]%}]%{$reset_color%}$%b "

        #source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      '';
    };
  };
}
