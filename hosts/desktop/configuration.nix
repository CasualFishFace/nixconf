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

      services.udev.extraRules = ''
        # 8BitDo Ultimate Bluetooth Controller's boot HID interface (seems to be shared by multiple 8BitDo devices)
        # Change it only if lsusb prints different Product ID when device is in bootloader mode.
        SUBSYSTEM=="hidraw", ATTRS{idProduct}=="3208", ATTRS{idVendor}=="2dc8", TAG+="uaccess"

        # 8BitDo Ultimate Bluetooth Controller receiver's HID interface (exposed when the controller is not connected)
        # When it is exposed, the upgrade tool can detect the receiver and automatically put in in bootloader mode.
        SUBSYSTEM=="hidraw", ATTRS{idProduct}=="3106", ATTRS{idVendor}=="2dc8", TAG+="uaccess"
      '';

      programs.gamemode.enable = true;
      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
      };

      environment.systemPackages = with pkgs; [
        bottles
        discord
        mangohud
        prismlauncher
      ];

      environment.sessionVariables = {
        # STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
      };

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    })
  ];
}
