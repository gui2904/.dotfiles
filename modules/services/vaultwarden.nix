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
    enable = lib.mkEnableOption "Enable Vaultwarden service";
  };

  config = lib.mkIf cfg.enable {
    services.vaultwarden = {
      enable = true;
      dbBackend = "postgresql";
      environmentFile = "/home/server/.vaultwarden/.env";  # Full path without '~'
      config = {
        SIGNUPS_ALLOWED = false;
      };
    };
  };
}

