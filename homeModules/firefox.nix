_top: {
  flake.homeModules.firefox = { config, ... }: let
    dotfiles = "${config.home.homeDirectory}/.config";
  in {
    programs.firefox.configPath = "${dotfiles}/mozilla/firefox";
  };
}
