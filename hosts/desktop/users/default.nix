# Define user accounts. Remember to set passwords with `passwd`.
{ lib, config, ... }: {
  home-manager.users =
    lib.genAttrs (builtins.attrNames config.users.users) (user: ./${user});
  
  users.users = {
    fishface = {
      isNormalUser = true;
      description = "Jovanni Bair";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = [];
    };
  };
}
