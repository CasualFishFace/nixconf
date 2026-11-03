{self, mylib, ...}: {
  flake.nixosConfigurations.desktop =
    mylib.mkHost "desktop" (with self.nixosModules; [
      ./_hardware-configuration.nix
      audio
      gaming
      librewolf
      ly
      niri
      noctalia
      nvidia
    ]);
}
