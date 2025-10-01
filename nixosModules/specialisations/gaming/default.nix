{ pkgs, config, lib, ... }: {
  options.myNixos.specialisations.gaming.enable = lib.mkEnableOption ''
    Enables the gaming specialisation, allowing it to appear in the bootloader.
  '';

  config.specialisation = let
    gaming = config.myNixos.specialisations.gaming;
  in lib.mkIf gaming.enable {
    gaming.configuration = {
      system.nixos.tags = [ "gaming" ];

      programs.gamemode.enable = true;
      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
      };

      environment.systemPackages = with pkgs; [
        bottles
        mangohud
        wl-clicker
      ];

      environment.sessionVariables = {
        # STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/fishface/.steam/root/compatibilitytools.d";
      };

      hardware.graphics.enable = true;
      hardware.nvidia.open = true;

      services.xserver.videoDrivers = [
        "nvidia" # NVIDIA graphics card
        # "amdgpu" # AMD graphics card
      ];

      # Enable this for further performance increases (only if you need it)
      # hardware.nvidia.modesetting.enable = true;
    };
  };
}
