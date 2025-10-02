{ lib, ... }: {
  options.myHome.theme = lib.mkOption {
    description = ''
      The system theme (determined by the subpath within
      `homeManagerModules/themes`).
    '';
    type = with lib.types; nullOr str;
    default = null;
  };
}
