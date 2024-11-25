{
  description = "nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    niqspkgs.url = "github:diniamo/niqspkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
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
