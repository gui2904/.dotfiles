{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  myEmacs =
    (pkgs.emacsPackagesFor
      inputs.emacs-overlay.packages.${pkgs.system}.emacs-pgtk)
      .emacsWithPackages
      (epkgs:
        (builtins.attrValues {
          inherit
            (epkgs.melpaPackages)
            vterm
          ;
        })
        ++ [epkgs.treesit-grammars.with-all-grammars]);
  
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
      enable = true;  
      client.enable = cfg.client.enable;
      package = myEmacs;
    };
  };
}
