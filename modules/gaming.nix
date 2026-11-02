{self, ...}: {
  flake.nixosModules.gaming = { pkgs, ... }: {
    imports = with self.nixosModules; [
      discord
    ];
    
    services.udev.extraRules = ''
      SUBSYSTEM=="hidraw", ATTRS{idProduct}=="3208", ATTRS{idVendor}=="2dc8", TAG+="uaccess"
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
  };
}
