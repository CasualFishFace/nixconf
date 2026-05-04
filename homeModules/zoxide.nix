_top: {
  flake.homeModules.zoxide = {
    programs.zoxide.enableBashIntegration = true;
    programs.zoxide.options = [
      "--cmd cd"
    ];
  };
}

