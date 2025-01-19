{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  # declare an emacs package derived from emacs, but it also compiles vterm
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
    enable = lib.mkEnableOption "emacs service";
    client.enable = lib.mkEnableOption "emacs client";
    standalone.enable = lib.mkEnableOption "emacs standalone";
  };

  config = lib.mkIf cfg.enable {
    services.emacs = {
      enable = true;
      client.enable = cfg.client.enable;
      package = myEmacs;
    };
    home.packages = [
      (lib.mkIf
        cfg.standalone.enable
        myEmacs)
    ];
  };
}
