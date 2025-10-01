{
  programs.helix.settings = {
    theme = "catppuccin_mocha";
    editor = {
      rulers = [ 80 ];
    };
  };

  programs.helix.languages.language = [
    {
      name = "rust";
      rulers = [ 100 ];
    }
    {
      name = "zig";
      rulers = [ 100 ];
    }
  ];

  programs.helix.languages.language-server = {};
}
