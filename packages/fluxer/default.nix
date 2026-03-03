{ inputs, ... }: let
  system = "x86_64-linux";
  pkgs = import inputs.nixpkgs { inherit system; };
in {
  flake.packages.${system}.fluxer = {
    fetchurl
  }: pkgs.stdenv.mkDerivation {
    pname = "fluxer";
    version = "latest";
    src = fetchurl "https://api.fluxer.app/dl/desktop/stable/linux/x64/latest/appimage";
    installPhase = ''
      chmod +x $src
      mkdir -p $out/bin
      cp $src $out/bin/fluxer
    '';
  };
}
