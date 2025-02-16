{...}: {
  home-manager.sharedModules = [
    ./users
  ];
  imports = [
    ./nix.nix
    ./local.nix
    ./fonts.nix
    ./bootloader.nix
  ];
}
