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
      mylib = import ./lib inputs;
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

