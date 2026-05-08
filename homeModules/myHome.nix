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

      theme.colors = let
        noctalia-path = "${config.home.homeDirectory}/.config/noctalia/colors.json";
        noctalia-colors = config.lib.file.mkOutOfStoreSymlink noctalia-path;
        noctalia-json = builtins.readFile noctalia-colors;
        noctalia-theme = builtins.fromJSON noctalia-json;
        mkColorOption = default: lib.mkOption {
          inherit default;
          type = lib.types.str;
        };
      in {
        primary = mkColorOption noctalia-theme.mPrimary;
        primary' = mkColorOption noctalia-theme.mOnPrimary;
        secondary = mkColorOption noctalia-theme.mSecondary;
        secondary' = mkColorOption noctalia-theme.mOnSecondary;
        tertiary = mkColorOption noctalia-theme.mTertiary;
        tertiary' = mkColorOption noctalia-theme.mOnTertiary;
        error = mkColorOption noctalia-theme.mError;
        error' = mkColorOption noctalia-theme.mOnError;
        surface = mkColorOption noctalia-theme.mSurface;
        surface' = mkColorOption noctalia-theme.mOnSurface;
        surfaceVariant = mkColorOption noctalia-theme.mSurfaceVariant;
        surfaceVariant' = mkColorOption noctalia-theme.mOnSurfaceVariant;
        outline = mkColorOption noctalia-theme.mOutline;
        shadow = mkColorOption noctalia-theme.mShadow;
        hover = mkColorOption noctalia-theme.mHover;
        hover' = mkColorOption noctalia-theme.mOnHover;
      };
    };
  };
}
