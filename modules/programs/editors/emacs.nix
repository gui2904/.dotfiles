{ lib, config, pkgs, inputs, ... }: let
  cfg = config.clover.programs.emacs;
in {
  options.clover.programs.emacs = {
    enable = lib.mkEnableOption "Enable Emacs";
    client.enable = lib.mkEnableOption "emacs client";
  };

  # Ensure enable is treated as a boolean and only apply if enabled
  config = lib.mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;  # Use the default Emacs package
      extraConfig = ''
         (setq user-emacs-directory (expand-file-name "~/.config/emacs/"))
         (load-file (concat user-emacs-directory "init.el"))
      '';
    };

    services.emacs = {
      enable = true;  # Disable as a system service if not needed
      package = pkgs.emacs;
    };
  };
}
