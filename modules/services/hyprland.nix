{ config, pkgs, ... }:

{
  systemd.user.services.hyprland = {
    serviceConfig.ExecStart = "${pkgs.hyprland}/bin/hyprland";
    wantedBy = [ "default.target" ];
  };
}
