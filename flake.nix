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
    self,
    wrappers,
    import-tree,
    flake-parts,
    ...
  }: flake-parts.lib.mkFlake rec {
    inherit inputs;
    specialArgs.mylib = map (p: import p {
      inherit inputs;
      inherit (inputs.nixpkgs) lib;
      inherit (specialArgs) mylib;
    }) (
      import-tree
        (i: i.addPath ./lib)
        (i: i.files)
    );
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

