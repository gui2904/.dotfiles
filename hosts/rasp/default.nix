{ config, lib, pkgs, inputs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];
 
  clover.users = {
    server.enable = true;
  };

  #boot.loader.grub.enable = false;
  #boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "rasp"; 
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    eza
  ];

  services = {
    openssh = { 
      enable = true;
      openFirewall = false;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
    udisks2.enable = true;
  };

  powerManagement.cpuFreqGovernor = "powersave";
  services.journald.extraConfig = ''
    SystemMaxUse=200M
    RuntimeMaxUse=100M
    MaxRetentionSec=7day
  '';

 

  # Open ports in the firewall.
  #networking.firewall.trustedInterfaces = [ "wlan0" ]; # replace with your LAN interface
  networking.firewall.allowedTCPPorts = [ 22 ];


  system.stateVersion = "24.05"; # Did you read the comment?

}

