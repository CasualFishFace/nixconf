{ inputs }: {
  flake.packages.x86_64-linux.huion-driver = let
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
  in {
    huion-driver = pkgs.stdenv.mkDerivation {
      pname = "huion-driver";
      version = "1.0";
      src = pkgs.fetchurl {
        url = "https://driverdl.huion.com/driver/Linux/HuionTablet_LinuxDriver_v15.0.0.175.x86_64.deb";
        hash = "sha256-vPTZJj8qgulCx5kpqJ2YQa3vUn/r+RxDAnqzMR8sPt4=";
      };
      nativeBuildInputs = [ pkgs.dpkg ];
      unpackPhase = ''
        dpkg-deb --fsys-tarfile $src | tar -x --no-same-owner
      '';
      installPhase = ''
        mkdir -p $out
        cp -r ./* $out/
      '';
    };
  };
}
