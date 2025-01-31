{ 
  config, 
  pkgs, 
  lib, 
  ... 
}: let
  cfg = config.clover.services.vaultwarden;
in {
  options.clover.services.vaultwarden = {
    enable = lib.mkEnableOption "enable zsh";
  };

  config = lib.mkIf cfg.enable {
    services.vaultwarden = {
      enable = true;
      dbBackend = "postgresql";
      environmentFile = "~/.vaultwarden/.env";
      config = {
        SIGNUPS_ALLOWED = false;
      };
    };
  };
}
