_top: {
  flake.homeModules.programs = {
    programs.ghostty = {
      enableBashIntegration = true;
      settings = {
        background-opacity = 0.7;
        gtk-titlebar = false;
        theme = "custom";
      };
    };
  };
}
