{ inputs, self, ... }: {
  flake.homeConfigurations.fishface = let
    inherit (inputs.home-manager) lib;
  in lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.fishface
    ];
  };
}
