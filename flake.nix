{
  description = ''Dendritic Nix config by CasualFishFace'';
  inputs = {
    nixpkgs.url = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    wrappers.url = "github:nix-community/nix-wrapper-modules";
  };
  outputs = inputs@{
    nixpkgs,
    wrappers,
    import-tree,
    flake-parts,
    ...
  }: flake-parts.lib.mkFlake rec {
    inherit inputs;
    specialArgs.mylib =
      let
        unevaluated =
          (import-tree.new
            (i: i.addPath ./lib)
            (i: i.map import)).leaves.result;
        evaluate = u: u {
          inherit inputs;
          inherit (nixpkgs) lib;
          inherit (specialArgs) mylib;
        };
        merged =
          let
            mapped = map evaluate unevaluated;
          in
          nixpkgs.lib.mergeAttrsList mapped;
      in
      merged;
  } {
    imports = [
      wrappers.flakeModules.wrappers
      (import-tree [
        ./features
        ./hosts
        ./modules
      ])
    ]; 
  };
}

