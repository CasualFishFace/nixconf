{
  description = "CasualFishFace's NixOS Config";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    import-tree.url = "github:vic/import-tree";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs@{ self, import-tree, home-manager, ... }: inputs.flake-parts.lib.mkFlake {
    inherit inputs;
  } {
    debug = true;
    imports = let
      inherit (inputs.nixpkgs) lib;
    in [
      home-manager.flakeModules.home-manager
      (import-tree.filterNot (lib.hasSuffix "hardware-configuration.nix") ./hosts)
      (import-tree [
        ./nixosModules
        ./homeConfigurations
        ./homeModules
      ])
    ];

    systems = [
      "x86_64-linux"
    ];
  };
}
