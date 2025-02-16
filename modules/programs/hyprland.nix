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
      xwayland.enable = true;
      systemd.enable = true;
      # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      settings = {
        "$term" = "${pkgs.foot}/bin/foot";
        "$fileManager" = "${pkgs.xfce.thunar}/bin/thunar";
        "$editor" = "${pkgs.emacs}/bin/emacsclient -nc -a 'vim'";
        "$menu" = "${pkgs.rofi}/bin/kill rofi || rofi -show drun -modi drun,filebrowser,run,window";

        env = [
          "term, $term"
          "editor, $editor"
          "XDG_CURRENT_DESKTOP,Hyprland"
        ];
        debug.disable_logs = false;

        workspaces = [
          
        ];
        exec-once = [
          "dbus-update-activation-environment --systemd --all"
          "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "waybar"
        ];

        general = {
          gaps_in = 4;
          gaps_out = 2;
          border_size = 2;
          layout = "dwindle";
        };

        decoration = {
          rounding = 0;
          blur = {
            enabled = false;
          };

        };

        animations.enabled = false;

        input = {
          kb_layout = "us";

          touchpad = {
            disable_while_typing = true;

            middle_button_emulation = true;
          };

        };
        "$mod" = "SUPER";
        bind = [
          "$mod, Return, exec, $term"
          "$mod, E, exec, emacsclient -nc -a 'helix'"
          "$mod, Q, killactive,"
          "$mod, M, exit,"
          "$mod, T, exec, $fileManager"
          "$mod SHIFT, F, togglefloating,"
          "$mod, D, exec, $menu"
          "$mod, P, pseudo, # dwindle"
          "$mod, J, togglesplit, # dwindle"

          # Brightnesss
          "XF86MonBrightnessUp, exec, brightnessctl set +10%"
          "XF86MonBrightnessDown, exec, brightnessctl set 10%-" 

          # Screenshots
          "$mod, S, exec, hyprshot -m window"
          "$mod SHIFT, S, exec, hyprshot -m region"

          # Window and workspaces
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"


          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"

        ];
        bindm = [
	        "$mod, mouse:272, movewindow"
	        "$mod, mouse:273, resizewindow"
        ];
      };
    };
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 19;
    };

    gtk = {
      enable = true;

      theme = {
        package = pkgs.flat-remix-gtk;
        name = "Flat-Remix-GTK-Grey-Darkest";
      };

      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };

      font = {
        name = "Sans";
        size = 11;
      };
    };
  };
}
