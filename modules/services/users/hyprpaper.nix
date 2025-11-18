{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.clover.services.hyprpaper;
in {
  options.clover.services.hyprpaper = {
    enable = lib.mkEnableOption "enable hyprpaper";
  };

  config = lib.mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "/home/laptop/Pictures/wallpapers/wallhaven-rqq3gm_1920x1080.png"
        ];
        wallpaper = [
          "eDP-1,/home/laptop/Pictures/wallpapers/wallhaven-rqq3gm_1920x1080.png"
        ];
      };
    }; 
  };
}
