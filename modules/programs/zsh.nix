{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    zprof.enable = false;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
     size = 10000;
     path = "${config.xdg.dataHome}/zsh/history";
    };
    
    initExtra = ''
      parse_git_branch() {
        git branch 2>/dev/null | sed -n '/\*/s/\* \(.*\)/ (\1)/p'
      }

	alias air='~/.air'

      autoload -U colors && colors
      function prompt() {
        PS1="%B%{$fg[red]%}[%{$fg[#A020F0]%}%n%{$fg[magenta]%}@%{$fg[magenta]%}%M %{$fg[#A020F0]%}%~%{$fg[#A020F0]%}$(parse_git_branch)%{$fg[reset]%}]%{$reset_color%}$%b "
      }
	precmd_functions+=(prompt)
    '';
  };
}
