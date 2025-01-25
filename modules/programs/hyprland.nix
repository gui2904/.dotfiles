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
      #xwayland.enable = true;
      settings = {
        "$term" = "${pkgs.foot}/bin/foot";
        #"$fileManager" = "${pkgs.thunar}/bin/thunar";
        #"$editor" = "${pkgs.emacs}/bin/emacsclient -c -a emacs";
        #"$menu" = "${pkgs.rofi}/bin/kill rofi || rofi -show drun -modi drun,filebrowser,run,window";

        env = [
          "term, $term"
          "editor, $editor"
          "XDG_CURRENT_DESKTOP,Hyprland"
          "HYPRCURSOR_SIZE=19"
        ];
        debug.disable_logs = false;

        workspaces = [
        ];
        exec-once = [
          "dbus-update-activation-environment --systemd --all"
          "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
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
        animations.enable = false;

        input = {
          kb_layoult = "us";
          touchpad = {
            natural_scroll = true;
          };
        };
        "$mod" = "SUPER";
        bind = [
          "$mod, Return, exec, $terminal"
          "$mod, E, exec, emacsclient -nc -a 'helix'"
          "$mod, Q, killactive,"
          "$mod, M, exit,"
          "$mod, T, exec, $fileManager"
          "$mod, F, togglefloating,"
          "$mod, D, exec, $menu"
          "$mod, P, pseudo, # dwindle"
          "$mod, J, togglesplit, # dwindle"
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
