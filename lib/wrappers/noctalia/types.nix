{ lib, ... }: {
  noctalia.types = {
    widget = let
      inherit (lib.types) either enum;
    in
    either (lib.types.submodule {
      group = lib.mkOption {
        type = lib.types.str;
      };
    }) (enum [
      "active-window"
      "audio-visualizer"
      "battery"
      "bluetooth"
      "brightness"
      "caffeine"
      "clipboard"
      "clock"
      "control-center"
      "cpu"
      "custom-button"
      "date"
      "input-volume"
      "keyboard-layout"
      "launcher"
      "lock-keys"
      "media"
      "network"
      "night-light"
      "notifications"
      "output-volume"
      "power-profile"
      "privacy-indicator"
      "ram"
      "screenshot"
      "session"
      "settings"
      "system-monitor"
      "taskbar"
      "temperature"
      "theme-mode"
      "tray"
      "volume"
      "wallpaper"
      "weather"
      "workspaces"

      "network-rx"
      "network-tx"
      "spacer"
      "text"
    ]);

    color = lib.types.enum [
      "primary"
      "on_primary"
      "primary_container"
      "on_primary_container"
      "secondary"
      "on_secondary"
      "secondary_container"
      "on_secondary_container"
      "tertiary"
      "on_tertiary"
      "tertiary_container"
      "on_tertiary_container"
      "error"
      "on_error"
      "error_container"
      "on_error_container"
      "outline_variant"
      "surface_container_low"
      "surface_container"
      "surface_container_high"
      "surface_container_highest"
    ];
  };
}
