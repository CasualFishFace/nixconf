{
  description = "CasualFishFace's NixOS Config";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    import-tree.url = "github:vic/import-tree";
    niri-flake.url = "github:sodiboo/niri-flake";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = inputs@{ self, import-tree, home-manager, flake-parts, ... }: flake-parts.lib.mkFlake {
    inherit inputs;
  } {
    # debug = true;
    imports = let
      inherit (inputs.nixpkgs) lib;
    in [
      home-manager.flakeModules.home-manager
      (import-tree.filterNot (lib.hasSuffix "hardware-configuration.nix") ./nixosConfigurations)
      (import-tree [
        ./nixosModules
        ./homeConfigurations
        ./homeModules
        ./packages
      ])
    ];

    systems = [ "x86_64-linux" ];
  };
}
