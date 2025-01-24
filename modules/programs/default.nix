{...}: {
  home-manager.sharedModules = [
    ./rofi.nix
    ./shells
    ./editors
    ./hyprland.nix
  ];
}
