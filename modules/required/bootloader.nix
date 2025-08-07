{...}: {
  boot.loader.grub = {
    enable = true;
    devices = [ "/dev/sda" ];
  };
}
