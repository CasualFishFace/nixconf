{self, mylib, ...}: {
  flake.nixosConfigurations.desktop-minimal = self.nixosModules.minimalHosts.desktop;
  flake.nixosModules.minimalHosts = {...}: {
    desktop = mylib.mkMinimalHost "desktop";
  };
}
