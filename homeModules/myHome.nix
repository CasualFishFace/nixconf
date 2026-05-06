_top: {
  flake.homeModules.myHome = { config, lib, ... }: {
    options.myHome = {
      launcher = lib.mkOption {
        default = null;
        type = with lib.types; nullOr package;
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
