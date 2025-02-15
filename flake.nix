{
  description = "nixos config";
  
  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      # "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
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
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    # emacs-overlay = {
    #   url = "github:nix-community/emacs-overlay";
    # };
  };
}
