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

  # Syncthing
  services.syncthing.enable = false;
  
  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.foot.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  programs.zsh.enable = true;

  # users.users.clover = {
  #   isNormalUser = true;
  #   shell = pkgs.zsh;
  #   extraGroups = [ "wheel" "networkmanager" "syncthing" "docker" ];
  #   packages = with pkgs; [
  #     vim 
  #     wget
  #     emacs
  #     firefox-wayland
  #     git
  #     gimp
  #     gtk3
  #     neofetch
  #     mpv
  #     pavucontrol
  #     pipewire
  #     pkg-config
  #     qt5.qtwayland
  #     qt6.qmake
  #     sddm
  #     unzip 
  #     waybar
  #     wofi
  #     jq
  #     grim
  #     slurp
  #     wl-clipboard
  #     libnotify
  #     wayland
  #     wayland-protocols
  #     pango
  #     cairo
  #     file
  #     libglvnd
  #     libwebp
  #     hyprlang
  #     hyprutils
  #     syncthing
  #     hyprwayland-scanner
  #     tree-sitter
  #     #python3.11-numpy
  #   ];
  # };

  users.groups.clover = {};


  #users.users.syncthing.extraGroups = [ "clover" ];

  # users.extraGroups.docker.members = [ "clover" ];

  environment.systemPackages = with pkgs; [
    gtk3
    hyprland
    syncthing
    rustup
    gcc
    docker
    gnumake
    zip
    cmake
    libtool
    eza
    vim
    git
    libglvnd
    libwebp
    hyprlang
    hyprutils
    pavucontrol
    pipewire
    pkg-config
    qt5.qtwayland
    qt6.qmake
    sddm
    unzip 
    waybar
    wofi
    jq
    grim
    slurp
    wl-clipboard
    libnotify
    wayland
    wayland-protocols
    pango
    cairo
    file
    libglvnd
    libwebp
    hyprlang
    hyprcursor
    hyprutils
    hyprwayland-scanner
    #emacsPackages.tree-sitter-langs
  ];  

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.thunar.enable = true;


  fonts.packages = with pkgs; [
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-code
    fira-code
    cantarell-fonts
    jetbrains-mono
    corefonts
    vistafonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    font-awesome
    dejavu_fonts
    jost
    inter
    lmodern
    roboto 
    nerd-fonts.jetbrains-mono
  ];

  # trash bin
  services.gvfs.enable = true;


  # List services that you want to enable:
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  #virtualisation.docker.enable = true;
  #virtualisation.docker.rootless = {
  #  enable = true;
  #  setSocketVariable = true;
  #};
	
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.locate = {
    enable = true;
    package = pkgs.plocate;
    localuser = null;
  };

  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.fontDir.enable = true;
  fonts.fontconfig.enable = true;


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}

