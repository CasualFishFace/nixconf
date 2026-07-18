{
  description = "CasualFishFace's NixOS Config";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    import-tree.url = "github:vic/import-tree";
    niri-flake.url = "github:sodiboo/niri-flake";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    wrappers.url = "github:birdeehub/nix-wrapper-modules";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    # nvf.url = "github:notashelf/nvf";
  };

  outputs = inputs@{
    self,
    import-tree,
    home-manager,
    flake-parts,
    wrappers,
    ...
  }: flake-parts.lib.mkFlake {
    inherit inputs;
  } {
    # debug = true;
    imports = let
      inherit (inputs.nixpkgs) lib;
    in [
      home-manager.flakeModules.home-manager
      wrappers.flakeModules.wrappers
      (import-tree.filterNot (lib.hasSuffix "hardware-configuration.nix") ./nixosConfigurations)
      (import-tree [
        ./nixosModules
        ./homeConfigurations
        ./homeModules
        ./packages
      ])
    ];

    perSystem = { pkgs, ... }: {
      wrappers.control_type = "exclude";
      wrappers.packages = {}; # packages to exclude/include.
    };

    systems = nixpkgs.lib.platforms.all;
  };
}
