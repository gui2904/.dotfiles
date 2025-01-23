{ lib, config, pkgs, ... }: let
  emacsDir = "${config.home.homeDirectory}/.config/emacs";
  cfg = config.clover.programs.emacs;
in {
  options.clover.programs.emacs = {
    enable = lib.mkEnableOption "Enable Emacs";
    client.enable = lib.mkEnableOption "Enable Emacs Client";
    standalone.enable = lib.mkEnableOption "Enable Emacs Standalone";
  };

  config = lib.mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;  # Use the default Emacs package
      client.enable = cfg.client.enable;
      extraConfig = ''
        (setq user-emacs-directory (expand-file-name "~/.config/emacs/"))
        (load-file (concat user-emacs-directory "init.el"))
      '';
    };

    services.emacs = {
      enable = true;
      client.enable = cfg.client.enable;
    };

  };
}
