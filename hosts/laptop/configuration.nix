{self, ...}: {
  flake.nixosConfigurations.laptop = self.nixosModules.hosts.laptop;
  flake.nixosModules.hosts = {lib, ...}: {
    laptop = lib.nixosSystem {
      modules = with self.nixosModules; [
        minimalHosts.laptop
        audio
        gaming
        librewolf

        {
          services.displayManager.ly.enable = true;
        }
      ];
    };
  };
}
