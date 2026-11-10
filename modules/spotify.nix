{...}: {
  flake.nixosModules.spotify = {config, pkgs, lib, ...}: {
    options.programs.spotify.enable = lib.mkEnableOption ''
      Enables Spotify, a music-player.
    '';

    config = {
      programs.spotify.enable = lib.mkDefault true;
      environment.systemPackages = lib.mkIf config.programs.spotify.enable [
        pkgs.spotify-pkayer
      ];
    };
  };
}
