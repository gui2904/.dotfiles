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
    python3
    ffmpeg
    thunar
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
