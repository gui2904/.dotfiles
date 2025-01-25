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

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n.defaultLocale = "en_US.UTF-8";

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    foot = {
      enable = true;
      settings.main.font = "Fira Code:size=14";
    };

    thunar.enable = true;
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    emacs = {
      enable = true;
      package = pkgs.emacs;
    };

    locate = {
      enable = true;
      package = pkgs.plocate;
      localuser = null;
    };

    dbus.enable = true;
    openssh.enable = true;
    gvfs.enable = true;
    libinput.enable = true;
  };

  environment.systemPackages = with pkgs; [
    dconf
    wget
    gnumake
    zip
    cmake
    libtool
    eza
    vim
    git
    libglvnd
    libwebp
    pavucontrol
    unzip 
    grim
    slurp
    libnotify
    libglvnd
    libwebp
    mesa

    # hypr dependencies
    wayland
    wayland-protocols
    hyprlang
    hyprutils
    hyprgraphics
    waybar
    dunst
    aquamarine
    hyprwayland-scanner
  ];  

  # fonts = {
  #   packages = with pkgs; [
  #     nerd-fonts.droid-sans-mono
  #     nerd-fonts.fira-code
  #     fira-code
  #     cantarell-fonts
  #     jetbrains-mono
  #     corefonts
  #     vistafonts
  #     noto-fonts
  #     noto-fonts-cjk-sans
  #     noto-fonts-emoji
  #     liberation_ttf
  #     font-awesome
  #     dejavu_fonts
  #     jost
  #     inter
  #     lmodern
  #     roboto 
  #     nerd-fonts.jetbrains-mono
  #   ];
  #   fontDir.enable = true;
  #   fontconfig.enable = true;
  # };

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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}

