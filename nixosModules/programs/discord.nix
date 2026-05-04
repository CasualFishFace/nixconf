_top: {
  flake.nixosModules.programs = { pkgs, config, lib, ... }: {
    options.programs.discord.enable = lib.mkEnableOption ''
      Enables `discord`. An all-in-one cross-platform voice and text chat for gamers.
    '';

    config = lib.mkIf config.programs.discord.enable {
      environment.systemPackages = [ pkgs.discord ];
    };
  };
}
