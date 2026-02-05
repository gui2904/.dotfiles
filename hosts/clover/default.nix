{ config, lib, pkgs, inputs, ... }:

{
  nix.settings.substituters = lib.mkBefore [
    "https://hyprland.cachix.org"
  ];
  nix.settings.trusted-public-keys = lib.mkBefore [
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];

  imports = [ 
    ./hardware-configuration.nix
  ];

  clover.users = {
    laptop.enable = true;
  };

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

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

    dconf.enable = true;
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    blueman = {
      enable = true;
    };

    locate = {
      enable = true;
      package = pkgs.plocate;
    };

    dbus.enable = true;
    openssh.enable = true;
    gvfs.enable = true;
    libinput.enable = true;

    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 40;
	STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };
 
  services.syncthing = {
    enable = true;
    user = "laptop";
    dataDir = "/home/laptop";
    configDir = "/home/laptop/.config/syncthing";

    settings = {
      devices = {
        desktop.id = "CV7RPTY-3SPYLEK-T3SAMAM-EHNZJCW-CWRRXMH-LVFBZZF-CUNUKOK-OUOXGAA";
        server.id = "5AAPDKC-OCEZFXM-WUHMOT4-DGCNL4C-3LZPUOS-IL4JVFJ-VPCNBWX-HLIEHAR";
      };
    };
  };
 
  nixpkgs.overlays = [ inputs.polymc.overlay ];

  environment.systemPackages = with pkgs; [
    # dconf
    cmake
    vim
    git
    wireplumber
    neofetch
    neovim
    kitty.terminfo

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

    jdk
    polymc
  ];  

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = false;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

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

