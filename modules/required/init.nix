{...}: {
  boot.initrd = {
    systemd.enable = true;
    verbose = false;
  };
}
