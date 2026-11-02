{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.noctalia = moduleWithSystem ({ self', ... }: {
    imports = [ inputs.noctalia.nixosModules.default ];
    nix.settings.substituters = [ "https://noctalia.cachix.org" ];
    nix.settings.trusted-public-keys = [ "noctalia.cachicx.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
    programs.noctalia = {
      enable = true;
      inherit (self'.outputs.wrappers.noctalia.config)
        recommendedServices
        systemd;
    };
  });
}
