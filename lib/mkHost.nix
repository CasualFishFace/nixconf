inputs: name: modules: inputs.nixpkgs.lib.nixosSystem {
  modules = modules ++ [ {
    networking.hostName = name;
  } ];
}
