{
  description = ''Dendritic Nix config by CasualFishFace'';
  inputs = {
    nixpkgs.url = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    wrappers.url = "github:nix-community/nix-wrapper-modules";
  };
  outputs = inputs: inputs.flake-parts.lib.mkFlake {
    inherit inputs;
    specialArgs = {
      mylib =
        let
          inherit (inputs.nixpkgs) lib;
          import-with-inputs = file: import file {
            inherit inputs lib;
            config = imported-content {};
          };
          mergeMap = f: list: lib.mergeAttrsList (map f list)
          imported-content = {}: mergeMap (import-tree ./lib).imports;
        in
        imported-content {};
    };
  } {
    imports = with inputs; [
      wrappers.flakeModules.wrappers
      (import-tree [
        ./features
        ./hosts
        ./modules
      ])
    ]; 
  };
}

