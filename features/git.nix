{ withSystem, ... }: {
  flake.wrappers.git = { pkgs, wlib, lib, ... }: {
    imports = [ wlib.wrapperModules.git ];

    settings = {
      core.editor = lib.getExe (withSystem pkgs.stdenv.hostPlatform.system ({ config, ... }:
        config.packages.helix
      ));

      user.email = "casualfishface@proton.me";
      user.name = "Fish Face";
    };
  };
}
