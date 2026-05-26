{ inputs, self, ... }: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      ./hardware-configuration.nix
      self.nixosModules.bundles
      self.nixosModules.users
      {
        myNixos.bundles.graphical.enable = true;
        myNixos.users.fishface.enable = true;
        
        networking.hostName = "desktop";
        nix.settings.trusted-users = [ "fishface" ];
        nixpkgs.overlays = [
          (_: prev: {
            openldap = prev.openldap.overrideAttrs {
              doCheck = false;
            };
          })
        ];

        # Internationalisation properties
        i18n.defaultLocale = "en_US.UTF-8";
        i18n.extraLocaleSettings = {
          LC_ADDRESS = "en_US.UTF-8";
          LC_IDENTIFICATION = "en_US.UTF-8";
          LC_MEASUREMENT = "en_US.UTF-8";
          LC_MONETARY = "en_US.UTF-8";
          LC_NAME = "en_US.UTF-8";
          LC_NUMERIC = "en_US.UTF-8";
          LC_PAPER = "en_US.UTF-8";
          LC_TELEPHONE = "en_US.UTF-8";
          LC_TIME = "en_US.UTF-8";
        };

        services.xserver.videoDrivers = [ "amdgpu" ];
        services.xserver.xkb = {
          layout = "us";
          variant = "";
        };

        # Never change this unless you know what you're doing.
        system.stateVersion = "25.11";
      }
    ];
  };
}
