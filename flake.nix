{
  description = ''
    CasualFishFace's NixOS & Home Manager configuration flake.
  '';

  inputs = {
    nixpkgs.url = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ... }: flake-parts.lib.mkFlake {
    inherit inputs;
  } (top: {
    imports = [
      ./hosts
      ./homeModules
      ./nixosModules
    ];

    systems = (import ./lib inputs).supportedSystems;

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
      # zen-browser = pkgs.stdenv.mkDerivation {
      #   pname = "zen-browser";
      #   version = "0.0.0";
      #   src = builtins.fetchGit {
      #     url = "https://github.com/zen-browser/desktop";
      #     rev = "b3736dfe3214c37aec6ada4717c1595ab90d92f9";
      #   };
      # };
    };
  });
}
