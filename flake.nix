{
  description = ''
    CasualFishFace's NixOS & Home Manager configuration flake.
  '';

  inputs = {
    nixpkgs.url = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      ./hosts
      ./homeModules
      ./nixosModules
      ./packages
    ];

    systems = [ "x86_64-linux" ];
  };
}
