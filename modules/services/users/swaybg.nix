{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.clover.services.swaybg;
in {
  options.clover.services.swaybg = {
    enable = lib.mkEnableOption "enable swaybg";
  };
  config = lib.mkIf cfg.enable = {
    services.swaybg = {
      enable = true;
      package = pkgs.swaybg;
      script = ''
        image=$(find ~/Pictures/wallpaper -type f | shuf -n 1)
        ${pkgs.swaybg}/bin/swaybg -i "$image"
      '';
    };
  };

}
