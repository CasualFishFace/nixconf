# Define user accounts. Remember to set passwords with `passwd`.
{ lib, ... }: {
  home-manager.users = lib.genAttrs [
    "fishface"
  ] (user: ./${user});
  
  users.users = {
    fishface = {
      isNormalUser = true;
      description = "Jovanni Bair";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = [];
    };
  };
}
