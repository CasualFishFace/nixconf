{
  description = ''
    CasualFishFace's NixOS & Home Manager configuration flake.
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs@{ self, nixpkgs, ... }: let
    myLib = import ./myLib inputs;
    inherit (myLib) mkAllSystems;
  in {
    nixosModules.default = ./nixosModules;
    nixosConfigurations = mkAllSystems [
      "desktop"
    ];
  };
}
