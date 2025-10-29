{ lib, ... }: {
  flake.homeModules.default = {
    options.myHome.theme = lib.mkOption {
      description = ''
        The user theme (determined by the subpath within the themes directory).
      '';
      type = with lib.types; nullOr str;
      default = null;
    };
  };
}
