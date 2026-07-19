{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.git = (inputs.wrappers.wrapperModules.git.apply {
      inherit pkgs;
      settings.core.editor = "$EDITOR";
    }).wrapper;
  };
}
