{moduleWithSystem, withSystem, ...}: {
  flake.wrappers.git = { pkgs, wlib, lib, ... }:
    let
      inherit (pkgs.stdenv.hostPlatform) system;
      packages = withSystem system ({self', ...}: self'.packages);
    in
    {
      imports = [ wlib.wrapperModules.git ];
      settings = {
        core.editor = lib.getExe packages.helix;
        user.email = "casualfishface@proton.me";
        user.name = "CasualFishFace";
      };
    };

  flake.nixosModules.myNixos = moduleWithSystem ({self', ...}: {lib, ...}: {
    programs.git.enable = lib.mkDefault true;
    programs.git.package = self'.packages.git;
  });
}
