{ config, lib, pkgs, inputs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];
 
  clover.users = {
    server.enable = true;
  };

  boot.loader.grub.enable = false;
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
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

  services = {
    openssh.enable = true; 
    jellyfin.enable = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8096 8920 ];
  networking.firewall.allowedTCPPortRanges = [ { from = 8096; to = 8096; } { from = 8920; to = 8920; } ];
  networking.firewall.trustedInterfaces = [ "wlan0" ]; # replace with your LAN interface


  system.stateVersion = "24.05"; # Did you read the comment?

}

