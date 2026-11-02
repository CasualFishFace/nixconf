{ inputs, moduleWithSystem, ... }: {
  flake.nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachicx.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };
  
  flake.nixosModules.noctalia = moduleWithSystem ({ self', ... }: {
    imports = [ inputs.noctalia.nixosModules.default ];
    programs.noctalia = {
      enable = true;
      inherit (self'.outputs.wrappers.noctalia.config)
        recommendedServices
        systemd;
    };
  });
}
