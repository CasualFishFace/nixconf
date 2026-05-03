{ config, ... }: {  
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
}
