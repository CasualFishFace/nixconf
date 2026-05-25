_top: {
  flake.nixosModules.audio = { lib, ... }: {
    services.pulseaudio = {
      enable = lib.mkDefault true;
    };

    services.pipewire = {
      enable = false;
      alsa.enable = true;
      alsa.support32Bit = true;
      audio.enable = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
