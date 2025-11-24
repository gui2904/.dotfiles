{
  pkgs,
  inputs,
  ...
}: { 
  clover = {
    programs = {
      zsh.enable = true;
      #emacs = {
      #  enable = false;
      #  client.enable = true;
      #};
    };

    services = {
      hyprland.enable = true;
      hyprpaper.enable = true;
    };

    fonts.enable = true;
  };



  home.packages = with pkgs; [
    firefox
    python3
    ffmpeg
    xfce.thunar
    nodejs
    mongodb-compass
    gnumake
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
  ];
  
  home.stateVersion = "24.05";
}
