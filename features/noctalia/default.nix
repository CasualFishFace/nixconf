{moduleWithSystem, inputs, ...}: {
  flake.wrappers.noctalia = {pkgs, wlib, ...}: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in
  {
    imports = [
      wlib.modules.default
    ];

    package = inputs.noctalia.packages.${system}.default;
    config-path = ./noctalia-full-config.toml;
  };
  flake.nixosModules.noctalia = moduleWithSystem ({...}: {
    systemd.tmpfiles.rules =
      let
        path = "/home/fishface/.config/noctalia/config.toml";
        cfg = ./noctalia-config.toml;
      in
      [
        "L+ ${path} - - - - ${cfg}"
      ];

    # Place a link inside /etc/nixos to some place outside of /etc/nixos
    # environment.etc."nixos/features/noctalia/noctalia-full-config.toml".source =
    #   "/home/fishface/.config/noctalia/config.toml";

    # programs.noctalia = {
    #   inherit (self'.wrapperModules.noctalia.config)
    #     recommendedServices
    #     systemd;
    # };
  });
}
