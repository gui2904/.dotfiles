{
  pkgs,
  inputs,
  config,
  ...
}: { 
  home.username = "clover";
  home.homeDirectory = "";
  
  clover = {
    programs = {
      zsh.enable = true;

      emacs.enable = {
        enable = true;
        client.enable = true;
        standalone.enable = true;
      };
    };
  };

  home.packages = with pkgs; [
    firefox
  ];
  
  home.stateVersion = "24.05";
}
