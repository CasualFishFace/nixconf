_top: {
  flake.homeModules.programs = {
    programs.ghostty = {
      enableBashIntegration = true;
      settings = {
        gtk-titlebar = false;
      };
    };
  };
}
