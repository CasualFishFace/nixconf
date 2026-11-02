{ self, mylib, ... }: {
  flake.nixosConfigurations.laptop = with self.nixosModules; mylib.mkHost "laptop" [
    ./_hardware-configuration.nix

    audio
    bootloader
    gaming
    librewolf
    minimalSystem
    networking
    niri
    noctalia
    time
    users
    zsh

    {
      services.displayManager.ly.enable = true;
    }
  ];
}
