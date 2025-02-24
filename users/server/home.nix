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
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

  home.stateVersion = "24.05";
}

