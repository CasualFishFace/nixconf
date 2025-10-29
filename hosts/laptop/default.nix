{ inputs, self' }: {
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ./configuration.nix
      ./hardware-configuration.nix
      self'.nixosModules.default
    ];
  };
}

