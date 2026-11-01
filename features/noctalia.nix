{ inputs, ... }: {
  flake.wrappers.noctalia = { pkgs, wlib, ... }: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    imports = [ wlib.modules.default ];
    package = inputs.noctalia.packages.${system}.default;
  };
}
