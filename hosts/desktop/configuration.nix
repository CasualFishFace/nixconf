{ self, mylib, ... }: let
  inherit (mylib) mkHost;
in {
  flake.nixosConfigurations.desktop = with self.nixosModules; mkHost "desktop" [
    ./_hardware-configuration.nix

    audio
    bootloader
    gaming
    librewolf
    minimalSystem
    networking
    niri
    noctalia
    nvidia
    time
    users
    zsh

    {
      services.displayManager.ly.enable = true;
    }
  ];
}
