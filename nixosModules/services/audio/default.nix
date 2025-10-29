{ lib, ... }: {
  flake.nixosModules.default = {
    # Enable sound with pipewire.
    services.pulseaudio.enable = lib.mkDefault false;
    security.rtkit.enable = lib.mkDefault false;
    services.pipewire = {
      enable = lib.mkDefault false;
      alsa.enable = lib.mkDefault true;
      alsa.support32Bit = lib.mkDefault true;
      pulse.enable = lib.mkDefault true;
      jack.enable = lib.mkDefault true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      # media-session.enable = true;
    };  
  };
}
