{self, ...}: {
  flake.nixosModules.minimalSystem = { ... }: {
    imports = with self.nixosModules; [ zsh ];
    nix.settings.trusted-users = [ "root" ];
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "26.05";
  };
}
