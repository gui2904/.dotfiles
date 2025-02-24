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
    };
  };

  home.packages = with pkgs; [
  ];

  home.stateVersion = "24.05";
}

