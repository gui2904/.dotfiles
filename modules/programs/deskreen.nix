{ config, lib, pkgs, ... }:
let
  cfg = config.clover.programs.deskreen;
  homeDir = config.home.homeDirectory;
  appImage = "${homeDir}/Apps/appimages/deskreen-ce-3.2.14-x86_64.AppImage";
in {
  options.clover.programs.deskreen = {
    enable = lib.mkEnableOption "Deskreen launcher";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.appimage-run
      pkgs.foot
    ];

    home.file.".local/bin/deskreen-local" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        APPIMAGE="${appImage}"

        if [ ! -f "$APPIMAGE" ]; then
          echo "AppImage not found: $APPIMAGE"
          exit 1
        fi

        if [ ! -x "$APPIMAGE" ]; then
          chmod +x "$APPIMAGE"
        fi

        exec ${pkgs.appimage-run}/bin/appimage-run "$APPIMAGE"
      '';
    };

    home.file.".local/share/applications/deskreen-local.desktop" = {
      text = ''
        [Desktop Entry]
        Type=Application
          Name=Deskreen
          Exec=${homeDir}/.local/bin/deskreen-local
          Icon=${homeDir}/.local/share/icons/hicolor/256x256/apps/deskreen-ce.png
          Terminal=false
          Categories=Network;Utility;
      '';
    };
  };
}
