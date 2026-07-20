{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.zoxide = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.zoxide;
      runtimeInputs = [];
      env = {};
      flags."--cmd" = "cd";
    };
  };
}
