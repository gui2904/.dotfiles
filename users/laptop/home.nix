{
  pkgs,
  inputs,
  config,
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
    kooha
    xfce.thunar
    nodejs
    mongodb-compass
  ];
  
  home.stateVersion = "24.05";
}
