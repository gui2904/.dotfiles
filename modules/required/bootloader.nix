{ config, lib, ... }:
{
  config = lib.mkMerge [
    (lib.mkIf (config.networking.hostName == "clover") {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.grub.enable = false;
    })

    (lib.mkIf (config.networking.hostName == "rasp") {
      boot.loader.systemd-boot.enable = false;
      boot.loader.efi.canTouchEfiVariables = false;
      boot.loader.grub.enable = false;
      boot.loader.generic-extlinux-compatible.enable = true;
    })
  ];
}

