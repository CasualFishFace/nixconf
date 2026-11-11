{self, mylib, ...}: {
  flake.nixosConfigurations.desktop =
    mylib.mkHost "desktop" (with self.nixosModules; [
      ./_hardware-configuration.nix
      gaming
      graphicalSystem
      librewolf
      ly
      niri
      noctalia
      nvidia
      {
        programs.direnv.enable = true;
        programs.direnv.enableZshIntegration = true;
        programs.direnv.nix-direnv.enable = true;
        environment.systemPackages = [ pkgs.spotify ];
      }
    ]);
}
