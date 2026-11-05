{moduleWithSystem, inputs, ...}: {
  flake.nixosModules.noctalia = moduleWithSystem ({system, ...}: {
    nix.settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
    };

    environment.systemPackages = [
      # self'.packages.noctalia
      inputs.noctalia.packages.${system}.default
    ];
  });
}
