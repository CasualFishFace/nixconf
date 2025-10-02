{
  description = ''
    CasualFishFace's NixOS & Home Manager configuration flake.
  '';

  inputs = {
    nixpkgs.url = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }: let
    lib = import ./lib inputs;
    inherit (lib) mkAllSystems mkAllHomes;
  in {
    nixosModules.default = ./nixosModules;
    homeManagerModules.default = ./homeManagerModules;

    nixosConfigurations = mkAllSystems [
      "desktop"
    ];

    homeConfigurations = mkAllHomes {
      fishface = { hosts = [ "desktop" ]; };
    };
  };
}
