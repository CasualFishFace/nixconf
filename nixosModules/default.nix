{ inputs, ... }: {
  imports = [
    ./bundles
    ./programs
    ./services
    ./system

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        backupFileExtension = "bak";
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    }
  ];
}
