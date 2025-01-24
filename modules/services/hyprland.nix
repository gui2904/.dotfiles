{ config, pkgs, lib, ... }: let
  cfg = config.clover.services.hyprland;

in {
  options = {
    clover.services.hyprland = { 
      enable = lib.mkEnableOption "hypr services"; 
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland services";
    }; 
  };

  config = lib.mkIf cfg.enable {
    systemd.clover.services.hyprland = {
    serviceConfig.ExecStart = "${pkgs.hyprland}/bin/hyprland";
    wantedBy = [ "default.target" ];
    };
  };
}
