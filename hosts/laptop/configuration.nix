{self, mylib, ...}: {
  flake.nixosConfigurations.laptop = self.nixosModules.hosts.laptop;
  flake.nixosModules.hosts = {...}: {
    laptop = mylib.mkHost "laptop" (with self.nixosModules; [
      ./_hardware-configuration.nix
      audio
      gaming
      librewolf
      ly
    ]);
  };
}
