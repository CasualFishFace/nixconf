_top: {
  flake.homeModules.programs = { pkgs, config, lib, ... }: {
    options.programs.stoat.enable = lib.mkEnableOption ''
      Enables Stoat, an open source user-first chat platform.
    '';

    config = lib.mkIf config.programs.stoat.enable {
      home.packages = [ pkgs.stoat-desktop ];
    };
  };
}

