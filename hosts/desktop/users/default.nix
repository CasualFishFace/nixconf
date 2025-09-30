# Define user accounts. Remember to set passwords with `passwd`.
{ lib, myLib, ... }: {
  home-manager.users = lib.genAttrs (dirsIn ./.) (username:
    ./${username}
  );
  
  users.users = {
    fishface = {
      isNormalUser = true;
      description = "Jovanni Bair";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = [];
    };
  };
}
