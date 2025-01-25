{...}: {
  home-manager.sharedModules = [
    ./users
    ./fonts.nix
  ];
  imports = [
    ./nix.nix
  ];
}
