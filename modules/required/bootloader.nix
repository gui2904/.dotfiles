{...}: {
  boot = {
    loader = {
      # you would not catch me dead using grub in any of my installs
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
