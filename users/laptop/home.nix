{
  pkgs,
  inputs,
  config,
  ...
}: { 
  # home.username = "laptop";
  # home.homeDirectory = "/home/laptop";
  
  clover = {
    programs = {
      zsh.enable = true;

      emacs = {
        enable = true;
        client.enable = true;
        standalone.enable = true;
      };

      hyprland.enable = true;
    };
  };
  
  systemd.user.services.hyprland = {
    serviceConfig.ExecStart = "${pkgs.hyprland}/bin/hyprland";
    wantedBy = [ "default.target" ];
  };

  home.packages = with pkgs; [
    firefox
  ];
  
  home.stateVersion = "24.05";
}
