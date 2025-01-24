{ config, pkgs, ... }:

{
  systemd.user.services.hyprland = {
    description = "Hyprland as a service";
    serviceConfig.ExecStart = "${pkgs.hyprland}/bin/hyprland";
    wantedBy = [ "default.target" ];
  };
}
