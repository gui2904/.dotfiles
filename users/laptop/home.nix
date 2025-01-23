{
  pkgs,
  inputs,
  ...
}: let 
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
