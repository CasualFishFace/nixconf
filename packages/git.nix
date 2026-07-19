{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.git = (inputs.wrappers.wrapperModules.git.apply {
      inherit pkgs;
      settings = {
        core.editor = "$EDITOR";
        user.email = "casualfishface@proton.me";
        user.name = "Fish Face";
      };
    }).wrapper;
  };
}
