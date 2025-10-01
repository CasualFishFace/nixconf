{ inputs, outputs, myLib, ... }: {
  imports = [
    ./bundles
    ./specialisations

    ./programs
    ./services
    ./system

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        extraSpecialArgs = { inherit inputs outputs myLib; };
        backupFileExtension = "bak";
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    }
  ];
}
