{self, ...}: {
  flake.nixosModules.graphicalSystem = {...}: {
    imports = with self.nixosModules; [
      bootloader
      fonts
      minimalSystem
      networking
      time
      users
    ];
  };
}
