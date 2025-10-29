{
  description = ''
    CasualFishFace's NixOS & Home Manager configuration flake.
  '';

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ... }: flake-parts.lib.mkFlake {
    inherit inputs;
    specialArgs.myLib = import ./lib inputs;
  } {
    imports = [
      inputs.home-manager.flakeModules.home-manager
      
      ./hosts
      ./homeModules
      ./nixosModules
      ./packages
    ];

    systems = (import ./lib inputs).supportedSystems;
  };
}
