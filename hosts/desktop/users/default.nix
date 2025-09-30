# Define user accounts. Remember to set passwords with `passwd`.
{  
  users.users = {
    fishface = {
      isNormalUser = true;
      description = "Jovanni Bair";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = [];
    };
  };
}
