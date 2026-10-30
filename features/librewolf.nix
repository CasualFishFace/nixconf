{ ... }: {
  perSystem = { pkgs, ... }: {
    packages.librewolf = pkgs.librewolf;
  };
}
