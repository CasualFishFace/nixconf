_top: {
  flake.homeModules.programs = {
    programs.zoxide.enableBashIntegration = true;
    programs.zoxide.options = [
      "--cmd cd"
    ];
  };
}

