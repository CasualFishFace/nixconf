{ lib, ... }: {
  mkHost = name: modules: lib.nixosSystem {
    modules = modules ++ [ {
      networking.hostName = name;
    } ];
  };
}
