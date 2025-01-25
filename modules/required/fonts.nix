{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.clover.fonts;
in {
  options.clover.fonts {
    enable = lib.mkEnableOption "enable fonts";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nerd-fonts.droid-sans-mono
      nerd-fonts.fira-code
      fira-code
      cantarell-fonts
      jetbrains-mono
      corefonts
      vistafonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      font-awesome
      dejavu_fonts
      jost
      inter
      lmodern
      roboto 
      nerd-fonts.jetbrains-mono
    ];
  };
}
