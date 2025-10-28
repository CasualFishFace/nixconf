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
      ./homeManagerModules
      ./nixosModules
    ];

    # flake.packages = let
    #   myLib = import ./lib inputs;
    # in myLib.forEachSystem ({ pkgs }: {
    #   zen-browser = pkgs.stdenv.mkDerivation {
    #     pname = "zen-browser";
    #     version = "0.0.0";
    #     src = builtins.fetchGit {
    #       url = "https://github.com/zen-browser/desktop";
    #       rev = "b3736dfe3214c37aec6ada4717c1595ab90d92f9";
    #     };
    #   };
    # });

    systems = [ "x86_64-linux" "aarch64-linux" ];
  });
}
