{ inputs, ... }: let
  inherit (inputs.nixpkgs) lib;
  myLib = import ./../lib inputs;
in {
  flake.nixosConfigurations = lib.genAttrs (myLib.dirsIn ./.) (hostName: lib.nixosSystem {
    specialArgs = { inherit inputs myLib; };
    modules = [
      (myLib.configurationFor hostName)
      inputs.self.outputs.nixosModules.default
    ];
  });
}
