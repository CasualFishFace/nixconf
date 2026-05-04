_top: {
  flake.homeModules.programs = { pkgs, config, lib, ... }: {
    options.programs.krita.enable = lib.mkEnableOption ''
      Enables Krita, a free and open source painting application.
    '';

    config = lib.mkIf config.programs.krita.enable {
      home.packages = [ pkgs.krita ];
    };
  };
}
