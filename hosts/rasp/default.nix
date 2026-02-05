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

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.generic-extlinux-compatible.enable = true;

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

  services.openssh = {
    enable = true;
    openFirewall = false;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  services.udisks2.enable = true;


  services.syncthing = {
    enable = true;
    user = "server";

    configDir = "/home/server/.config/syncthing";
    dataDir = "/home/server/Sync";

    openDefaultPorts = true; 
    guiAddress = "127.0.0.1:8384";

    extraFlags = [
      "--gui-insecure-admin-access"
    ];

    settings = {
      gui = {
        insecureAdminAccess = false;
        allowedHosts = [
          "localhost"
          "localhost:18384"
          "syncthing-server.local"
          "syncthing-server.local:18384"
        ];
      };


      devices = {
        desktop = {
          id = "CV7RPTY-3SPYLEK-T3SAMAM-EHNZJCW-CWRRXMH-LVFBZZF-CUNUKOK-OUOXGAA";
        };
      };


      folders.notes = {
        path = "/home/server/Sync/notes";
        devices = [ "desktop" ];
      };
    };
  };
 

  # Open ports in the firewall.
  #networking.firewall.trustedInterfaces = [ "wlan0" ]; # replace with your LAN interface
  networking.firewall.allowedTCPPorts = [ 22 ]; #SSH and Vaultwarden


  system.stateVersion = "24.05"; # Did you read the comment?

}

