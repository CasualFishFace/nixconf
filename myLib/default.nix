inputs@{ self, nixpkgs, ... }: rec {
  mkAllSystems = hosts: nixpkgs.lib.genAttrs hosts mkSystem;
  mkSystem = host: let
    config = ./../hosts/${host}/configuration.nix;
  in nixpkgs.lib.nixosSystem {
    specialArgs = { flake-inputs = inputs; };
    modules = [ config self.outputs.nixosModules.default ];
  };
}
