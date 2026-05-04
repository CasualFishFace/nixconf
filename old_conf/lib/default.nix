{ nixpkgs, ... }: rec {
  # Helper functions ==========================================================

  firstFileStartingWith = directory: prefix: let
    entries = builtins.readDir directory;
    filtered = nixpkgs.lib.filterAttrs (name: type:
      (type == "regular") &&
      (nixpkgs.lib.hasPrefix prefix name)
    ) entries;
  in builtins.head (builtins.attrNames filtered);

  # Theme functions ===========================================================

  themes = rec {
    dir = ./../themes;

    path = name: if name != null then "${dir}/${name}" else null;

    scheme = name: let
      directory = path name;
      p = "${directory}/scheme.yaml";
    in if name != null && builtins.pathExists p then p else null;

    wallpaper = name: let
      directory = path name;
      fileName = firstFileStartingWith directory "wallpaper.";
      p = "${directory}/${fileName}";
    in if name != null && builtins.pathExists p then p else null;
  };
}
