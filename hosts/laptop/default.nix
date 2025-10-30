{ inputs, self, ... }: {
  flake.nixosConfigurations.laptop= inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ./configuration.nix
      ./hardware-configuration.nix
      self.outputs.nixosModules.default
    ];
  };
}

