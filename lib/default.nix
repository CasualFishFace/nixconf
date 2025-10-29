{ nixpkgs, ... }: rec {
  supportedSystems = [
    "x86_64-linux"
    "x86_64-darwin"
    "aarch64-linux"
    "aarch64-darwin"
  ];

  forEachSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
    pkgs = import nixpkgs { inherit system; };
  });
  
  # Helper functions ==========================================================

  firstFileStartingWith = directory: prefix: let
    entries = builtins.readDir directory;
    filtered = nixpkgs.lib.filterAttrs (name: type:
      (type == "regular") &&
      (nixpkgs.lib.hasPrefix prefix name)
    ) entries;
  in builtins.head (builtins.attrNames filtered);

  dirsIn = dir: let
    entries = builtins.readDir dir;
    filtered = nixpkgs.lib.filterAttrs (_: t: t == "directory") entries;
  in builtins.attrNames filtered;

  # Theme functions ===========================================================

  themes = rec {
    dir = ./../themes;

    path = name: if name != null then "${dir}/${name}" else null;

    wallpaper = name: let
      directory = path name;
      fileName = firstFileStartingWith directory "wallpaper.";
      p = "${directory}/${fileName}";
    in if name != null && builtins.pathExists p then p else null;

    scheme = name: let
      directory = path name;
      p = "${directory}/scheme.yaml";
    in if name != null && builtins.pathExists p then p else null;
  };
}
