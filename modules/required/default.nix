{...}: {
  home-manager.sharedModules = [
    ./users
  ];
  imports = [
    ./nix.nix
  ];
}
