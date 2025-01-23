{
  lib,
  config,
  pkgs,
  ...
}: let
  emacsDir = "${config.home.homeDirectory}/.config/emacs";
in {
  options.clover.programs.emacs = {
    enable = lib.mkEnableOption "Enable Emacs";
    client.enable = lib.mkEnableOption "emacs client";
    standalone.enable = lib.mkEnableOption "emacs standalone";
  };

  config = lib.mkIf config.clover.programs.emacs.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;  # Use the default Emacs package
  

      extraConfig = ''
        (setq user-emacs-directory (expand-file-name "~/.config/emacs/"))
        (load-file (concat user-emacs-directory "init.el"))
      '';
    };
    
    services.emacs = {
      enable = true;
      package = pkgs.emacs;
    };
  }; 
 }
