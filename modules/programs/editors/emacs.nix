{ lib, config, pkgs, inputs, ... }: let
  emacsDir = "${config.home.homeDirectory}/.config/emacs";
  cfg = config.clover.programs.emacs;
in {
  options.clover.programs.emacs = {
    enable = lib.mkEnableOption "Enable Emacs";
    standalone.enable = lib.mkEnableOption "Enable Emacs Standalone";
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

    # Optional: If you want Emacs as a service (disable if unnecessary)
    services.emacs = {
      enable = false;  # Disable as a system service if not needed
    };

    # Add Emacs package to the home environment if standalone is enabled
    home.packages = lib.mkIf cfg.standalone.enable [
      pkgs.emacs
    ];
  };
}
