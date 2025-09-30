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
  };

  outputs = inputs@{ self, nixpkgs, ... }: let
    myLib = import ./myLib inputs;
    inherit (myLib) mkAllSystems mkAllHomes;
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
