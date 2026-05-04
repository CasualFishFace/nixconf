{
  flake.nixosModules.default = { lib, ... }: {
    options.myNixos.theme = lib.mkOption {
      description = ''
        The system theme (determined by the subpath within the themes directory).
      '';
      type = with lib.types; nullOr str;
      default = null;
    };
  };
}
