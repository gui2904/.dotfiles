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


      hyprland.enable = true;
    };
  };
  

  home.packages = with pkgs; [
    firefox
  ];
  
  home.stateVersion = "24.05";
}
