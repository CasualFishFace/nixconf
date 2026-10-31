{ self, mylib, ... }: let
  inherit (mylib) mkHost;
in {
  flake.nixosConfigurations.desktop = with self.nixosModules; mkHost "desktop" [
    ./_hardware-configuration.nix

    audio
    bootloader
    librewolf
    minimalSystem
    networking
    niri
    nvidia
    time
    users
    zsh

    ({ pkgs, ... }: {
      services.displayManager = {
        ly.enable = true;
      };

      environment.systemPackages = [ pkgs.discord ];
    })
  ];
}
