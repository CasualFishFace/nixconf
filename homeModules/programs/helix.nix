_top: {
  flake.homeModules.programs = { config, lib, ... }: {
    config = lib.mkIf config.programs.helix.enable {
      programs.helix.settings = {
        editor.line-number = "relative";
        theme = "custom";
      };

      programs.helix.themes = {
        custom = {
          inherits = "github_dark";
          "ui.background" = "transparent";
        };
      };
    };
  };
}
