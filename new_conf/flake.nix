{
  description = "CasualFishFace's NixOS Config";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    # home-manager.url = "github:nix-community/home-manager";
    import-tree.url = "github:vic/import-tree";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs@{ self, ... }: inputs.flake-parts.lib.mkFlake {
    inherit inputs;
  } {
    debug = true;
    imports = [ (inputs.import-tree [
      ./bundles
      ./hosts
      ./nixosModules
    ]) ];

    systems = [
      "x86_64-linux"
    ];
  };
}
