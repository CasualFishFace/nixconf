{self, ...}: {
  flake.nixosConfigurations.desktop = self.nixosModules.hosts.desktop;
  flake.nixosModules.hosts = {lib, ...}: {
    desktop = lib.nixosSystem {
      modules = with self.nixosModules; [
        minimalHosts.desktop
        audio
        gaming
        librewolf
        niri
        noctalia
        nvidia

        {
          services.displayManager.ly.enable = true;
        }
      ];
    };
  };
}
