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
          "hyprpaper"
        ];

        general = {
          gaps_in = 2;
          gaps_out = 2;
          border_size = 1;
          layout = "dwindle";
        };

        decoration = {
          rounding = 1;
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

        cursor = {
          zoom_rigid = true;
          zoom_detached_camera = false;
        };

        "$mod" = "SUPER";
        bind = [
          "$mod, Return, exec, $term"
          "$mod, E, exec, emacsclient -nc -a 'helix'"
          "$mod, Q, killactive,"
          "$mod, M, exit,"
          "$mod, T, exec, $fileManager"
          "$mod, F, fullscreen"
          "$mod SHIFT, F, togglefloating,"
          "$mod, D, exec, ~/.config/rofi/launchers/type-2/launcher.sh || pkill rofi"
          "$mod, P, pseudo, # dwindle"
          "$mod, J, togglesplit, # dwindle"
 
          # Move Focus
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          # Resize Windows
          "$mod SHIFT, H, resizeactive,-50 0"
          "$mod SHIFT, L, resizeactive,50 0"
          "$mod SHIFT, K, resizeactive,0 -50"
          "$mod SHIFT, J, resizeactive,0 50"

          # Move Windows
          "$mod CTRL, H, movewindow, l"
          "$mod CTRL, L, movewindow, r"
          "$mod CTRL, K, movewindow, u"
          "$mod CTRL, J, movewindow, d"

          # Swap Windows
          "$mod ALT, H, swapwindow, l"
          "$mod ALT, L, swapwindow, r"
          "$mod ALT, K, swapwindow, u"
          "$mod ALT, J, swapwindow, d"

          # Brightnesss
          ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
          ", XF86MonBrightnessDown, exec, brightnessctl set 10%-" 

          # Volume
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

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
        bindl = [
          # Zoom
          "$mod, Z, exec, hyprctl keyword cursor:zoom_factor 2.5"
        ];
        bindrl = [
          # Zoom
          "$mod, Z, exec, hyprctl keyword cursor:zoom_factor 1"
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
