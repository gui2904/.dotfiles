{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.clover.services.jellyfin;
in {
  options.clover.services.jellyfin = {
    enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      dataDir = "/home/server/jellyfin/data";
      user = "server";
    };
  };
}
