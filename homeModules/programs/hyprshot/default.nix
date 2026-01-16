{ config, ... }: {
  programs.hyprshot.saveLocation = config.home.homeDirectory + "/Pictures";
}
