{ lib, config, pkgs, inputs, ... }: let
  emacsDir = "${config.home.homeDirectory}/.config/emacs";
  cfg = config.clover.programs.emacs;
in {
  options.clover.programs.emacs = {
    enable = lib.mkEnableOption "Enable Emacs";
    # client.enable = lib.mkEnableOption "emacs client";  
    standalone.enable = lib.mkEnableOption "Enable Emacs Standalone";
  };

  # Ensure enable is passed correctly as a boolean
  config = lib.mkIf cfg.enable {
    programs.emacs = {#   enable = true;
      enable = true;
      package = pkgs.emacs;  # Use the default Emacs package
      extraConfig = ''
        (setq user-emacs-directory (expand-file-name "~/.config/emacs/"))
        (load-file (concat user-emacs-directory "init.el"))
      '';
    };

    # You may not need to enable `services.emacs` if you only want user-level Emacs configuration
    services.emacs = {
      enable = false;  # Disable if you only want user-level config
    };
    home.packages = [
      (lib.mkIf
        cfg.standalone.enable)
    ];
  };
}
