# Define user accounts. Remember to set passwords with `passwd`.
{
  home-manager.users = {
    fishface = ./fishface;
  };
  
  users.users = {
    fishface = {
      isNormalUser = true;
      description = "Jovanni Bair";
      extraGroups = [ "networkmanager" "wheel" "video" ];
      packages = [];
    };
  };
}
