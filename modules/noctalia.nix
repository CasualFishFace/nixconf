{inputs, moduleWithSystem, ...}: {
  flake.nixosModules.noctalia = moduleWithSystem ({system, ...}: {
    nix.settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
    };

    programs.noctalia = {
      enable = true;
      package = inputs.noctalia.packages.${system}.default;
    };
  });

  flake.wrappers = {
    helix.themes.custom.inherits = "noctalia";
    ghostty.settings.theme = "noctalia";
  };
}
