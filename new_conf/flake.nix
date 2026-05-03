{
  description = "CasualFishFace's NixOS Config";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs@{ self, ... }: inputs.flake-parts.lib.mkFlake {
    inherit inputs;
  } {
    debug = true;
    imports = [
      ./hosts
    ];

    systems = [
      "x86_64-linux"
    ];
  };
}
