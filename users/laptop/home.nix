{
  pkgs,
  inputs,
  ...
}: { 
  clover = {
    programs = {
      zsh.enable = true;
      hyprland.enable = true;
      emacs = {
        enable = true;
        client.enable = true;
      };
    };

    services = {
      hyprpaper.enable = true;
    };

    fonts.enable = true;
  };



  home.packages = with pkgs; [
    firefox
    ffmpeg
    thunar
    nodejs
    mongodb-compass
    zip
    unzip 
    pavucontrol
    brightnessctl
    wev
    hyprpaper
    libreoffice
    go
    iamb

    libtool
    libglvnd
    libwebp

    deluge
    eza
 
    #Treesitter
    gcc
    gnumake
    python3
    pkg-config
  ];
  
  home.stateVersion = "24.05";
}
