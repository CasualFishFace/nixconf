{ inputs, myLib, ... }: {
  imports = [
    ./bundles
    ./programs
    ./services
    ./specialisations
    ./system
    ./themes
  ];
  
  flake.nixosModules.default = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      inputs.stylix.nixosModules.stylix

      {
        home-manager = {
          extraSpecialArgs = { inherit inputs myLib; };
          backupFileExtension = "bak";
          useGlobalPkgs = true;
          useUserPackages = true;
        };
      }
    ];
  };
}
