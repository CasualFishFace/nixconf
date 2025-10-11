{ inputs, ... }: let
  inherit (inputs.nixpkgs) lib;
  inherit (inputs.self) outputs;
  myLib = import ./../lib inputs;
in {
  flake.nixosConfigurations = let
    hosts = myLib.dirsIn ./.;
    configurationFor = hostName: ./. + "${hostName}/configuration.nix";
  in lib.genAttrs hosts (hostName: lib.nixosSystem {
    specialArgs = { inherit inputs outputs myLib; };
    modules = [
      (configurationFor hostName)
      outputs.nixosModules.default
    ];
  });
}
