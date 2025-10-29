{ outputs, system, pkgs, config, lib, ... }: {
  options.programs.krita.enable = lib.mkEnableOption ''
    Enables Krita, a FOSS digital art program.
  '';

  config = lib.mkIf config.programs.krita.enable {
    home.packages = [ outputs.packages.${system}.huion-driver pkgs.krita ];
  };
}
