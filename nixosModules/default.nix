{ inputs, myLib, ... }: {
  imports = [
    ./bundles
    ./programs
    ./services
    ./specialisations
    ./system
    ./themes

    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
  ];

  flake.nixosModules.default = {
    imports = [{
      home-manager = {
        extraSpecialArgs = { inherit inputs myLib; };
        backupFileExtension = "bak";
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    }];
  };
}
