{inputs, moduleWithSystem, ...}: {
  flake.nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };
  flake.nixosModules.noctalia = moduleWithSystem ({pkgs, ...}:
    let
      inherit (pkgs.stdenv.hostPlatform) system;
    in {
      imports = [
        inputs.noctalia.nixosModules.default
      ];

      nix.settings = {
        trusted-substituters = [ "https://noctalia.cachix.org" ];
        trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
      };

      environment.systemPackages = [
        inputs.noctalia.packages.${system}.default
      ];
    }
  );
}
