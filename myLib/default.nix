inputs@{ self, nixpkgs, ... }: rec {
  mkAllSystems = hosts: nixpkgs.lib.genAttrs hosts (host:
    mkSystem ./../hosts/${host}/configuration.nix
  );
  
  mkSystem = config: nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [ config self.outputs.nixosModules.default ];
  };
}
