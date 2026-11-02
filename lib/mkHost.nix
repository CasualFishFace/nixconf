{self, lib, ...}: rec {
  mkHost = name: modules: lib.nixosSystem {
    modules = modules ++ [ {
      networking.hostName = name;
    } ];
  };
  mkMinimalHost = {
    name,
    hardware-config-path,
  }: with self.nixosModules; mkHost name [
    hardware-config-path
    bootloader
    fonts
    minimalSystem
    networking
    time
    users
  ];
}
