{ self, mylib, ... }: {
  flake.nixosConfigurations.minlap = with self.nixosModules; mylib.mkHost "laptop" [
    ./_hardware-configuration.nix

    bootloader
    minimalSystem
    networking
    time
    users
    zsh
  ];
}
