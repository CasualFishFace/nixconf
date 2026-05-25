_top: {
  flake.nixosModules.audio = { lib, ... }: {
    serivces.pulseaudio = {
      enable = lib.mkDefault true;
    };

    services.pipewire = {
      enable = lib.mkDefault false;
      alsa.enable = true;
      alsa.support32Bit = true;
      audio.enable = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
