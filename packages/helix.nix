{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.helix = (inputs.wrappers.wrapperModules.helix.apply {
      inherit pkgs;

      settings = {
        editor = {
          bufferline = "multiple";
          color-modes = true;
          cursorline = true;
          indent-heuristic = "tree-sitter";
          inline-diagnostics = {
            cursor-line = "hint";
            other-lines = "error";
          };
          jump-label-alphabet = "1234567890";
          line-number = "relative";
          mouse = false;
          rulers = [ 100 ];
        };

        theme = "custom";
      };

      themes.custom = {
        inherits = "github_dark";
        "ui.background" = "transparent";
      };
    }).wrapper;
  };
}
