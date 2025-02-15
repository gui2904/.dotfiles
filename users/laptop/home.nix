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
      emacs.enable = true;
      hyprland.enable = true;
    };

    fonts.enable = true;
  };
  
  

  home.packages = with pkgs; [
    firefox
    python3
  ];
  
  home.stateVersion = "24.05";
}
