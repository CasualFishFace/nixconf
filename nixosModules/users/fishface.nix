{ self, ... }: {
  flake.nixosModules.users = { config, lib, ... }: {
    options.myNixos.users.fishface.enable = lib.mkEnableOption ''
      Adds the user 'fishface' to the system configuration
    '';
    config = lib.mkIf config.myNixos.users.fishface.enable {
      home-manager.users.fishface = let
        usingHome = config.home-manager != null;
      in lib.mkIf usingHome self.homeModules.fishface;

      users.users.fishface = {
        isNormalUser = true;
        description = "CasualFishFace";
        extraGroups = [ "networkmanager" "wheel" "video" ];
      };
    };
  };
}
