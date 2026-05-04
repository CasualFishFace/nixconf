{ inputs, ... }: {
  homeConfigurations.fishface = let
    inherit (inputs.home-manager) lib;
  in lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      ({ pkgs, ... }: {
        home = {
          stateVersion = "25.05";
          username = "fishface";
          homeDirectory = "/home/fishface";
          packages = [
            (pkgs.writeShellScriptBin "startgaming" ''
              sudo /run/current-system/specialisation/gaming/bin/switch-to-configuration switch
            '')
          ];
        };
      })
    ];
  };
}
