{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Schizofox

  # Foot
  programs.foot = {
    enable = true;
    theme = "chiba-dark";
    settings.main.font = "Fira Code:size=11";
  };

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  
  # services.blueman.enable = true;

  # Syncthing
  services.syncthing.enable = true;
  
  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.clover = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "syncthing" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
     vim 
     wget
     emacs
     foot
     firefox-wayland
     git
     gimp
     gtk3
     neofetch
     mpv
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
     hyprutils
     syncthing
     hyprwayland-scanner
   ];
  };

  users.groups.clover = {};

  users.users.syncthing.extraGroups = [ "clover" ];

  environment.systemPackages = with pkgs; [
    hyprland
    syncthing
    foot
    rustup
    gcc
  ];  

  # permissions for syncthing
  systemd.tmpfiles.rules = [ "d /var/lib/syncthing 0777 syncthing syncthing" ];

  programs.hyprland.enable = true;

  programs.thunar.enable = true;

  # hardware.bluetooth.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    fira-code
    cantarell-fonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
	
  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

   services.locate = {
      enable = true;
      package = pkgs.plocate;
      localuser = null;
   };

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

