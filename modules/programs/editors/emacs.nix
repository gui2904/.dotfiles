{ lib, config, pkgs, ... }: let
  emacsDir = "${config.home.homeDirectory}/.config/emacs";
in {
  options.clover.programs.emacs = {
    enable = lib.mkEnableOption "Enable Emacs";
    client.enable = lib.mkEnableOption "Enable Emacs Client";
    standalone.enable = lib.mkEnableOption "Enable Emacs Standalone";
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

    # Assuming you want to enable Emacs as a service (optional)
    services.emacs = {
      enable = true;
      package = pkgs.emacs;
    };
  };
}
