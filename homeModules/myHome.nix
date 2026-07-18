_top: {
  flake.homeModules.myHome = { pkgs, config, lib, ... }: {
    options.myHome = {
      launcher = lib.mkOption {
        default = pkgs.fuzzel;
        type = lib.types.package;
      };

      statusBar = lib.mkOption {
        type = lib.types.package;
      };

      terminal = lib.mkOption {
        type = lib.types.package;
      };
    };
  };
}
