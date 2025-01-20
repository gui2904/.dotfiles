{
  pkgs,
  config,
  lib,
  ...
}: let
  catppuccinDrv = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/foot/009cd57bd3491c65bb718a269951719f94224eb7/catppuccin-mocha.conf";
    hash = "sha256-plQ6Vge6DDLj7cBID+DRNv4b8ysadU2Lnyeemus9nx8=";
  };
  cfg = config.clover.programs.foot;
in {
  options.clover.programs.foot = {
    enable = lib.mkEnableOption "foot";
  };

  config =
    lib.mkIf cfg.enable {
      programs.foot = {
        enable = true;
        settings = {
          main = {
            include = "${catppuccinDrv}";
            font = "Fira Code:size=11";
          };
        };
      };
    };
}
