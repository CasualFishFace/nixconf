{
  programs.helix.settings = {
    # theme = "catppuccin_mocha";
    editor = {
      bufferline = "multiple";
      line-number = "relative";
      rulers = [ 80 ];
    };
  };

  programs.helix.languages.language = let
    withRulers = rulers: builtins.map (l: { name = l; rulers = rulers; });
  in withRulers [ 100 ] [
    "haskell"
    "nix"
    "rust"
    "zig"
  ];

  programs.helix.languages.language-server = {};
}
