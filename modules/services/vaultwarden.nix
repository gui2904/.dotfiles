{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.clover.services.vaultwarden;
in {
  options.clover.services.vaultwarden = {
    enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf cfg.enable {
    services.vaultwarden = {
      enable = true;
    };
  };
}
