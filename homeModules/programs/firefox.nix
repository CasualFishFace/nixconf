_top: {
  flake.homeModules.programs = { config, ... }: let
    dotfiles = "${config.home.homeDirectory}/.config";
  in {
    programs.firefox.configPath = "${dotfiles}/mozilla/firefox";
  };
}
