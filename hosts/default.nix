{ inputs, ... }: let
  inherit (inputs.nixpkgs) lib;
  myLib = import ./../lib inputs;
in {
  flake.nixosConfigurations = let
    hosts = myLib.dirsIn ./.;
    configurationFor = hostName: ./. + "/${hostName}/configuration.nix";
  in lib.genAttrs hosts (hostName: lib.nixosSystem {
    specialArgs = { inherit inputs myLib; };
    modules = [
      (configurationFor hostName)
      inputs.self.outputs.nixosModules.default
    ];
  });
}
