{
  pkgs,
  inputs,
  ...
}: { 
  clover = {
    programs = {
      zsh = {
        enable = true;
      };
      emacs = {
        enable = true;
        client.enable = true;
      };
      hyprland.enable = true;
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

    libtool
    libglvnd
    libwebp

    eza
  ];
  
  home.stateVersion = "24.05";
}
