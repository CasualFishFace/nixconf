{ pkgs, config, lib, ... }: {
  options.programs.discord.enable = lib.mkEnableOption ''
    Enables the Discord Instant Messenger
  '';

  config = lib.mkIf config.programs.discord.enable {
    home.packages = [ pkgs.discord ];
  };
}
