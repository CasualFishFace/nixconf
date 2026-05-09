_top: {
  perSystem = { pkgs, ... }: {
    packages.theme-switcher = pkgs.writers.writePython3Bin "theme-switcher" {}
      (builtins.readFile ./src.py);
  };
}
