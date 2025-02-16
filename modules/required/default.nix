{ lib, ... }: {
  home-manager.sharedModules = [
    ./users
    ./fonts.nix
  ];
  imports = [
    ./nix.nix
    ./local.nix
    ./bootloader.nix
    ./init.nix
  ];
}
