{self, mylib, ...}: {
  flake.nixosConfigurations.laptop =
    mylib.mkHost "laptop" (with self.nixosModules; [
      ./_hardware-configuration.nix
      gaming
      graphicalSystem
      librewolf
      ly
      niri
      noctalia
    ]);
}
