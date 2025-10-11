{ inputs, ... }: let
  inherit (inputs.nixpkgs) lib;
  inherit (inputs.self) outputs;
  myLib = import ./../lib inputs;
in {
  flake.nixosConfugurations = let
    hosts = myLib.dirsIn ./.;
    configuration = hostName: ./. + "${hostName}/configuration.nix";
  in lib.genAttrs hosts (hostName: lib.nixosSystem {
    specialArgs = { inherit inputs outputs myLib; };
    modules = [
      (configuration hostName)
      outputs.nixosModules.default
    ];
  });
}
