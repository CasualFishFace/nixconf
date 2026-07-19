{ inputs, ... }: let
  settings = ''
    [editor]
    bufferline = "multiple"
    color-modes = true
    cursorline = true
    indent-heuristic = "tree-sitter"
    jump-label-alphabet = "1234567890"
    line-number = "relative"
    mouse = false
    rainbow-brackets = true
    rulers = [ 100 ]
    theme = "custom"

    [editor.inline-diagnostics]
    cursor-line = "hint"
    other-lines = "error"
  '';
in {
  perSystem = _args: {
    packages.helix = inputs.wrapper-modules.wrappers.helix.wrap {
      inherit settings;
      # settings = {
      #   editor = {
      #     bufferline = "multiple";
      #     color-modes = true;
      #     cursorline = true;
      #     indent-heuristic = "tree-sitter";
      #     inline-diagnostics = {
      #       cursor-line = "hint";
      #       other-lines = "error";
      #     };
      #     jump-label-alphabet = "1234567890";
      #     line-number = "relative";
      #     mouse = false;
      #     rainbow-brackets = true;
      #     rulers = [ 100 ];
      #   };

      #   theme = "custom";
      # };

      themes.custom = {
        inherits = "github_dark";
        "ui.background" = "transparent";
      };
    };
  };
}
