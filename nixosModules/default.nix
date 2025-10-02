{ inputs, outputs, myLib, ... }: {
  imports = [
    ./bundles
    ./programs
    ./services
    ./specialisations
    ./system

    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix

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
