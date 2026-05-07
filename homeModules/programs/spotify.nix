_top: {
  flake.homeModules.programs = { pkgs, config, lib, ... }: {
    options.programs.spotify.enable = lib.mkEnableOption ''
      Enables Spotify, the music player.
    '';

    config = lib.mkIf config.programs.spotify.enable {
      home.packages = [ pkgs.spotify ];
    };
  };
}
