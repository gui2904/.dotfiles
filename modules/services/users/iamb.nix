{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.clover.services.iamb;
in {
  options.clover.services.iamb = {
    enable = lib.mkEnableOption "enable iamb";
  };

  config = lib.mkIf cfg.enable {
    services.iamb = {
      enable = true;
      default_profile = "personal";
      settings = {
        notifications.enabled = true;
        image_preview.protocol = {
          type = "kitty"; 
          size = {
            height = 10;
            width = 66;
          };
        };
      };
    };
  };
}
