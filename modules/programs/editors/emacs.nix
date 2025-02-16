{
  lib,
  config,
  pkgs,
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
            nix-mode
            ;
          inherit (epkgs.treesit-grammars) with-all-grammars;
        }));
  
  cfg = config.clover.programs.emacs;
in {
  options.clover.programs.emacs = {
    enable = lib.mkEnableOption "Enable Emacs";
    client.enable = lib.mkEnableOption "emacs client";
  };

  config = lib.mkIf cfg.enable {
    services.emacs = {
      enable = true;  
      client.enable = cfg.client.enable;
      package = myEmacs;
    };

    programs.emacs = {
      enable = true;
      package = myEmacs;
      extraConfig = ''
        (setq user-emacs-directory (expand-file-name "~/.config/emacs/"))
        (load-file (concat user-emacs-directory "init.el"))
      '';
    };

  };
}
