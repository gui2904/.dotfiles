{
  pkgs,
  inputs,
  config,
  ...
}: { 
  home.username = "laptop";
  home.homeDirectory = "/home/clover";
  
  clover = {
    programs = {
      zsh.enable = true;

      emacs = {
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
