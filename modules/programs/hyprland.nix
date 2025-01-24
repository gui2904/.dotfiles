{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.clover.programs.hyprland;

in {
  options.clover.programs.hyprland = {
    enable = lib.mkEnableOption "enable hyprland";
  };  
  
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
      settings = {
        
	"$terminal" = "${pkgs.foot}/bin/foot";
	#"$fileManager" = "${pkgs.thunar}/bin/thunar";
        #"$editor" = "${pkgs.emacs}/bin/emacsclient -c -a emacs";
	#"$menu" = "${pkgs.rofi}/bin/kill rofi || rofi -show drun -modi drun,filebrowser,run,window";

        env = [
          "term, $term"
          "editor, $editor"
          "XDG_CURRENT_DESKTOP,Hyprland"
        ];
        debug.disable_logs = false;
        
        workspaces = [
          
        ];

        general = {
          gaps_in = 4;
          gaps_out = 2;
          border_size = 2;
        };
        
        decoration = {
          blur = {
            enabled = false;
          };
          animations.enabled = false;
        };

        input = {
          kb_layoult = "us";
          touchpad = {
            natural_scroll = true;
          };
        };
        "$mainMod" = "SUPER";
        bind = [
	  "$mainMod, Return, exec, $terminal"
	  "$mainMod, E, exec, emacsclient -nc -a 'helix'"
	  "$mainMod, Q, killactive,"
	  "$mainMod, M, exit,"
	  "$mainMod, T, exec, $fileManager"
	  "$mainMod SHIFT, F, togglefloating,"
	  "$mainMod, D, exec, $menu"
	  "$mainMod, P, pseudo, # dwindle"
	  "$mainMod, J, togglesplit, # dwindle"
        ];
      };
  };
}
