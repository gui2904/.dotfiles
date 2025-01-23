{
  pkgs,
  inputs,
  ...
}: { 
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
  home.stateVersion = "24.05";
}
