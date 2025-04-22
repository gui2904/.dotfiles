{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.clover.programs.git; 
in {
  options.clover.programs.git = {
    enable = lib.mkEnableOption "Enable Git with ssh signing";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      signing = {
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
      extraConfig.gpg.format = "ssh";
    };
  };
}    
