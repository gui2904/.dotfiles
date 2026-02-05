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
    openssl
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


    settings = {
      gui = {
        insecureAdminAccess = false;
        guiAllowedHosts = [
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
        laptop = {
          id = "H3UN5LJ-M6E5SPJ-4SAYULE-2OSHIWL-Q53DSCD-3XLVPRT-56DOE5T-BBRYWQ2";
        };
      };


      folders.notes = {
        path = "/home/server/Sync/notes";
        devices = [ "desktop" "laptop" ];
      };
    };
  };

  services.forgejo = {
    enable = true;
    stateDir = "/var/lib/forgejo";

    settings = {
      server = {
        DOMAIN = "localhost";
        HTTP_PORT = 3000;
        ROOT_URL = "http://localhost:3000/";
      };

      service.DISABLE_REGISTRATION = false;
    };
  };


  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 3000 ]; #SSH and Vaultwarden


  system.stateVersion = "24.05"; # Did you read the comment?

}

