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
      pkgs.figlet
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
        ec = "emacsclient -nc -a 'vim'";
	      nv = "nvim";
        ls = "eza --icons";
        TERM = "xterm-kitty";
      };
      # sessionVariables = {
      #   EDITOR = "vim";
      # };

      history = {
        expireDuplicatesFirst = true;
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
        append = true;
      };

      initContent = ''
        [[ -o interactive ]] || return

          center_art() {
            local file="$1"
            local cols="${COLUMNS:-$(tput cols)}"
            while IFS= read -r line; do
              local len=$#line
              local pad=$(( (cols - len) / 2 ))
              (( pad < 0 )) && pad=0
              printf "%*s%s\n" "$pad" "" "$line"
            done < "$file"
          }

          center_art ~/.config/branding/art.txt


        autoload -U colors && colors
        autoload -Uz add-zsh-hook

        # Movement bindings
        bindkey -v
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        bindkey "^A" beginning-of-line
        bindkey "^E" end-of-line

        function parse_git_branch() {
          git branch 2>/dev/null | sed -n '/\*/s/\* \(.*\)/ (\1)/p'
        }

        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
        PS1="%B%{$fg[red]%}[%{$fg[#A020F0]%}%n%{$fg[magenta]%}@%{$fg[magenta]%}%M %{$fg[#A020F0]%}%~%{$fg[#A020F0]%}$(parse_git_branch)%{$fg[reset]%}]%{$reset_color%}$%b "

        export HYPRSHOT_DIR="$HOME/Pictures/Screenshots/"
        export GPG_TTY=$(tty)
      '';
    };
  };
}
