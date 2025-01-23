{
  description = "nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      clover = lib.nixosSystem {
    inherit system;
    modules = [
          ./hosts/clover/configuration.nix
        ];
      };
    };
    homeConfigurations."clover" = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    modules = [ 
          ./hosts/clover/home.nix
          ./modules
        ];
    };
   };
}
