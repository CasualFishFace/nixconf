_top: {
  flake.nixosModules.programs = { pkgs, config, lib, ... }: {    
    options.programs.ghostty.enable = lib.mkEnableOption ''
      Enables `ghostty`, a fast, native, feature-rich terminal emulator pushing modern features.
    '';

    config = lib.mkIf config.programs.ghostty.enable {
      environment.systemPackages = [ pkgs.ghostty ];
    };
  };
}
