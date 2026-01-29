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
    enable = lib.mkEnableOption "enable vaultwarden";
  };

  config = lib.mkIf cfg.enable {
    services.vaultwarden = {
      enable = true;
      config = {
        ROCKET_ADDRESS = "0.0.0.0";
        ROCKET_PORT = 8000;
      };
      # environmentFile = "/etc/vaultwarden.env"; # recommended for ADMIN_TOKEN
    };
  };
}
