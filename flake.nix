{
  description = "nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    niqspkgs.url = "github:diniamo/niqspkgs";
    schizofox.url = "github:schizofox/schizofox";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        specialArgs = { inherit inputs self; };
        inherit system;
        modules = [
          ./hosts/clover/configuration.nix
          ./modules
          inputs.home-manager.nixosModules.default
        ];
      };
    };
    };
  };
}
