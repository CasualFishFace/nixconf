{self, mylib, ...}: {
  flake.nixosConfigurations.laptop-minimal = self.nixosModules.minimalHostModules.laptop;
  flake.nixosModules.minimalHosts = {...}: {
    laptop = mylib.mkMinimalHost "laptop";
  };
}
