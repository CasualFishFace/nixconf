{self, mylib, ...}: {
  flake.nixosConfigurations.laptop =
    mylib.mkHost "laptop" (with self.nixosModules; [
      ./_hardware-configuration.nix
      audio
      gaming
      librewolf
      ly
    ]);
}
