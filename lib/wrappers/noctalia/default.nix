{ config, lib, ... }: {
  noctalia = {
    mkColorOption = default: lib.mkOption {
      inherit default;
      type = lib.types.nullOr config.noctalia.types.color;
    };
    mkBorderOption = { color, width }: lib.mkOption {
      default = {
        inherit color width;
      };
      type = lib.types.submodule {
        color = config.noctalia.mkColorOption null;
        width = lib.mkOption {
          default = 2.0;
          type = lib.types.float;
        };
      };
    };
    mkLayerOption = default: lib.mkOption {
      inherit default;
      type = lib.types.enum [ "top" "overlay" ];
    };
    mkBarSectionOption = default: lib.mkOption {
      inherit default;
      type = with lib.types; listOf config.noctalia.types.widget;
    };
  };
}
