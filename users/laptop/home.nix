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
    #services = {
    #  hyprland.enable = true;
    #};
  };
  

  home.packages = with pkgs; [
    firefox
  ];
  environment.variables = {
    WAYLAND_DISPLAY = "wayland-0";
    XDG_RUNTIME_DIR = "/run/user/1001";
  };
  
  home.stateVersion = "24.05";
}
