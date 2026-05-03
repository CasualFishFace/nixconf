{ inputs, ... }: {
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      {
        imports = [ ./desktop/configuration.nix ];

        # Flakes, experimental features, overlays.
        nix.settings.experimental-features = [ "nix-command" "flakes" ];
        nix.settings.trusted-users = [ "root" "fishface" ];
        nixpkgs.config.allowUnfree = true;
        nixpkgs.overlays = [];
      }
    ];
  };
}
