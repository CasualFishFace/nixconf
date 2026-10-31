{ ... }: pkgs: attrs: let
  system = pkgs.stdenv.hostPlatform.system;
in attrs.${system}
