{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];

  clover.users = {
    laptop.enable = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "clover"; 
  networking.networkmanager.enable = true;


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    foot = {
      enable = true;
      settings.main.font = "Fira Code:size=14";
    };
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    locate = {
      enable = true;
      package = pkgs.plocate;
    };

    dbus.enable = true;
    openssh.enable = true;
    gvfs.enable = true;
    libinput.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # dconf
    cmake
    vim
    git
    wireplumber

    # dependencies
    # Hyprland
    wayland
    wayland-protocols
    hyprlang
    hyprutils
    hyprgraphics
    hyprshot
    waybar
    dunst
    aquamarine
    hyprwayland-scanner

    # Hyprshot
    jq
    grim
    slurp
    wl-clipboard
  ];  

  xdg.portal = {
    config.common.default = "hyprland;wlr;gtk";
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05"; # Did you read the comment?


}

