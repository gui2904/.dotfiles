{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.clover.fonts;
in {
  options.clover.fonts = {
    enable = lib.mkEnableOption "enable fonts";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      #Monospace for coding
      nerd-fonts.fira-code

      #UI / system
      cantarell-fonts
      noto-fonts
      roboto

      # Emoji / icons
      noto-fonts-emoji
      font-awesome
    ];

    fonts.fontconfig.enable = true;
  };
}
