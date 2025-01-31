{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.clover.users.server;
in {
  options.clover.users.server = {
    enable = lib.mkEnableOption "enable server user";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.server = import ./home.nix;

    users.users.server = {
      isNormalUser = true;
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
      extraGroups = ["wheel" "clover" "networkmanager" "input" "video"];
    };
  };
}
