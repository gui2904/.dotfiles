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
        carapace.enable = true;
      };

      #emacs = {
      #  enable = true;
      #  client.enable = true;
      #  standalone.enable = true;
      #};

      hyprland.enable = true;
    };
  };
  

  home.packages = with pkgs; [
    firefox
  ];
  
  home.stateVersion = "24.05";
}
