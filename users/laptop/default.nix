{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.clover.users.laptop;
in {
  options.clover.users.laptop = {
    enable = lib.mkEnableOption "enable user";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.laptop = import ./home.nix;

    users.users.laptop = {
      isNormalUser = true;
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
      extraGroups = ["wheel" "input"];
    };
  };
}

