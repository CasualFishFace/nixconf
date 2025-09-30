{ pkgs, config, lib, ... }: {
  options.programs.discord.enable = lib.mkEnableOption ''
    Enables the Discord Instant Messenger
  '';

  config.home.packages = lib.mkIf config.programs.discord.enable [
    pkgs.discord
  ];
}
