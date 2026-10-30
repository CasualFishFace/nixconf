{ moduleWithSystem, ... }: {
  flake.nixosModules.users = moduleWithSystem ({ self', ... }: {
    users.users.fishface = {
      description = "F.F.";
      extraGroups = [ "root" "wheel" "video" ];
      isNormalUser = true;
      shell = self'.packages.zsh;
    };
  });
}
