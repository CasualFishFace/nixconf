{self, ...}: {
  flake.nixosModules.graphicalSystem = {...}: {
    imports = with self.nixosModules; [
      audio
      bootloader
      fonts
      minimalSystem
      networking
      time
      users
    ];
  };
}
