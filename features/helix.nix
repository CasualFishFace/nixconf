{ moduleWithSystem, ... }: {
  flake.wrappers.helix = { pkgs, wlib, ... }: {
    imports = [ wlib.wrapperModules.helix ];

    runtimePkgs = [ pkgs.nixd ];

    languages = {};

    settings = {
      editor = {
        bufferline = "always";
        color-modes = true;
        cursorline = true;
        indent-heuristic = "hybrid";
        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "error";
        };
        # jump-label-alphabet = "1234567890";
        line-number = "relative";
        mouse = false;
        rulers = [ 80 ];
      };

      theme = "custom";
    };

    themes.custom = {
      inherits = "github_dark";
      "ui.background" = "transparent";
    };
  };

  flake.nixosModules.helix = moduleWithSystem ({ self', ... }: {
    programs.helix.enable = true;
    programs.helix.package = self'.packages.helix;
  });
}
