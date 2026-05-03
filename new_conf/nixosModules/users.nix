_top: let
  mkUser = name: attrs: {
    users.users.${name} = attrs;
  };
in {
  flake.nixosModules.users = {
    fishface = mkUser "fishface" {
      isNormalUser = true;
      description = "CasualFishFace";
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
      ];
    };
  };
}
