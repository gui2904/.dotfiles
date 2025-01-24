{ config, pkgs, lib, ... }: 
let
  cfg = config.clover.services.hyprland;
in {
  options = {
    clover.services.hyprland.enable = lib.mkEnableOption "hypr services";
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.hyprland = {
      serviceConfig.ExecStart = "${pkgs.hyprland}/bin/hyprland";
      wantedBy = [ "default.target" ];
    };
  };
}
