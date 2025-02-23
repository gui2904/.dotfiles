{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.clover.services.hyprpaper;
in {
  options.clover.services.hyprpaper = {
    enable = lib.mkEnableOption "enable hyprpaper";
    wallpaperPath = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      description = "the wallpaper you want";
      default = [];
    };
  };

  config = lib.mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      # package = inputs.hyprpaper.packages.${pkgs.system}.hyprpaper;
      settings = let
        wallpaper = "${../wallpapers}/gangle-under-streetlight_Tumblr-ff.jpg";
      in {
        preload = [
          wallpaper
        ];
        wallpaper = [
          "eDP-1, ${wallpaper}"
          "HDMI-A-1, ${wallpaper}"
        ];
      };
    };
  };


}
