{ self, mylib, ... }: let
  inherit (mylib) mkHost;
in {
  flake.nixosConfigurations.desktop = with self.nixosModules; mkHost "desktop" [
    ./_hardware-configuration.nix

    audio
    bootloader
    minimalSystem
    networking
    nvidia
    time
    users

    {
      services.displayManager = {
        enable = true;
        autoLogin = {
          enable = true;
          user = "fishface";
        };
      };
    }
  ];
}
