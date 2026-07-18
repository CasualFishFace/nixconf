_top: {
  flake.wrappers.helix = { pkgs, wlib, ... }: {
    imports = [ wlib.wrapperModules.helix ];

    settings = {
      editor = {
        bufferline = "multiple";
        line-number = "relative";
        rulers = [ 100 ];
      };

      theme = "custom";
    };

    themes.custom = {
      inherits = "github_dark";
      "ui.background" = "transparent";
    };
  };
}
