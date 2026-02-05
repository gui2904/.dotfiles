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
      };


      folders.notes = {
        path = "/home/server/Sync/notes";
        devices = [ "desktop" ];
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

  services.vaultwarden = {
    enable = true;
    config = {
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;

      # Use the URL you will actually type in your browser:
      DOMAIN = "http://10.0.0.12";

      SIGNUPS_ALLOWED = false;
      ROCKET_LOG = "normal";
    };
  };

  services.nginx = {
    enable = true;

    # Catch-all HTTP vhost so you can access by IP
    virtualHosts."_" = {
      listen = [ { addr = "0.0.0.0"; port = 80; } ];

      locations."/" = {
        proxyPass = "http://127.0.0.1:8222";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };
  };



  # Open ports in the firewall.
  #networking.firewall.trustedInterfaces = [ "wlan0" ]; # replace with your LAN interface
  networking.firewall.allowedTCPPorts = [ 22 80 3000 ]; #SSH and Vaultwarden


  system.stateVersion = "24.05"; # Did you read the comment?

}

