{inputs, moduleWithSystem, ...}: {
  flake.nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };
  flake.nixosModules.noctalia = moduleWithSystem ({self', ...}: {
    programs.noctalia = {
      package = self'.packages.noctalia;
      recommendedServices.enable = true;
      systemd.enable = true;
    };
  });
}
