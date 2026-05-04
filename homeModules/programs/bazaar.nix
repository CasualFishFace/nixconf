_top: {
  flake.homeModules.programs = { pkgs, config, lib, ... }: {
    options.programs.bazaar.enable = lib.mkEnableOption ''
      Enables Bazaar, a FlatHub-first app store for GNOME.
    '';

    config = lib.mkIf config.programs.bazaar.enable {
      home.packages = [ pkgs.bazaar ];
    };
  };
}
