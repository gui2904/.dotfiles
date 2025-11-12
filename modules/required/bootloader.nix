{...}: {
  #boot.loader.grub = {
  #  enable = true;
  #  efiSupport = true;
  #  device = "nodev"; # do NOT use /dev/nvme0n1 in EFI mode
  #};

  #boot.loader.efi = {
  #  canTouchEfiVariables = true;
  #};

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;
}
