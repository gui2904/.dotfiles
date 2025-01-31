{
  description = "nixos config";
 
  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      req-modules = [
        ./modules
        ./users
      ];
      home-module = [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = {inherit inputs;};
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = ".bak";
          };
        }
      ];
    in {
      nixosConfigurations = {
        clover = lib.nixosSystem {
          specialArgs = {inherit system inputs;};
          modules = req-modules ++ home-module ++ [
            ./hosts/clover
          ];
        };
        rasp = lib.nixosSystem {
          specialArgs = {inherit system inputs;};
          modules = req-modules ++ home-module ++ [
            ./hosts/rasp
          ];
        };
      };
    };
}
