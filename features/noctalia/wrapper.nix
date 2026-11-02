{ inputs, mylib, ... }: {
  flake.wrappers.noctalia = { pkgs, wlib, lib, ... }: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    imports = [
      wlib.modules.default
    ];
    config.runtimePkgs = [
      inputs.noctalia.packages.${system}.default
    ];
    options = {
      recommendedServices.enable = lib.mkEnableOption ''
        Enables wifi, bluetooth, power-profile, and battery features.
      '';
      systemd.enable = lib.mkEnableOption ''
        Enables noctalia as a systemd service.
      '';
      settings = {
        accessibility = {
          high_contrast = lib.mkEnableOption ''
            Enables a high contrast UI for Noctalia.
          '';
          ui_scale = lib.mkOption {
            description = ''
              Changes the scale of the UI for Noctalia.
            '';
            default = 1.0;
            type = lib.types.float;
          };
        };
        audio = {
          enable_notification_sounds = lib.mkOption {
            description = "";
            default = true;
            type = lib.types.str;
          };
          enable_overdrive = lib.mkOption {
            description = "";
            default = false;
            type = lib.types.bool;
          };
          enable_power_sounds = lib.mkOption {
            description = "";
            default = true;
            type = lib.types.bool;
          };
          enable_screenshot_sounds = lib.mkOption {
            description = "";
            default = true;
            type = lib.types.bool;
          };
          enable_sounds = lib.mkOption {
            description = "";
            default = true;
            type = lib.types.bool;
          };
          enable_volume_sounds = lib.mkOption {
            description = "";
            default = true;
            type = lib.types.bool;
          };
          sound_theme = lib.mkOption {
            description = "";
            default = "freedesktop";
            type = lib.types.bool;
          };
          sound_volume = lib.mkOption {
            description = "";
            default = 0.5;
            type = lib.types.bool;
          };
          spectrum_frame_rate = lib.mkOption {
            description = "";
            default = 60;
            type = lib.types.int;
          };
        };
        backdrop = {
          enabled = lib.mkEnableOption "";
          blur_intensity = {
            description = "";
            default = 0.5;
            type = lib.types.float;
          };
          tint_intensity = {
            description = "";
            default = 0.3;
            type = lib.types.float;
          };
        };
        bar-order = lib.mkOption {
          description = "";
          default = [ "default" ];
          type = with lib.types; listOf str;
        };
        bars = lib.mkOption {
          type = let
            inherit (lib.types) attrsOf submodule;
          in attrsOf (submodule {
            enable = lib.mkOption {
              default = true;
              type = lib.types.bool;
            };
            auto-hide.enable = lib.mkEnableOption "";
            auto-hide.delay-ms = lib.mkOption {
              default = 0;
              type = lib.types.int;
            };
            background.opacity = lib.mkOption {
              default = 1.0;
              type = lib.types.int;
            };
            border = mylib.noctalia.mkBorderOption {
              width = 1.0;
              color = "outline_variant";
            };
            capsule.enable = lib.mkEnableOption "";
            capsule.border = mylib.noctalia.mkBorderOption {
              width = 1.0;
              color = "outline_variant";
            };
            capsule.fill-color = mylib.noctalia.mkColorOption "surface_container";
            capsule.opacity = lib.mkOption {
              default = 1.0;
              type = lib.types.float;
            };
            capsule.thickness = lib.mkOption {
              default = 0.75;
              type = lib.types.float;
            };
            color = mylib.noctalia.mkColorOption "primary";
            compositor.blur = lib.mkEnableOption "";
            concave-edge-corners = lib.mkOption {
              default = true;
              type = lib.types.bool;
            };
            contact-shadow = lib.mkEnableOption "";
            font.scale = lib.mkOption {
                default = 1.0;
                type = lib.types.float;
              };
            font.weight = lib.mkOption {
              default = 400;
              type = lib.types.int;
            };
            hover-highlight = lib.mkOption {
              default = true;
              type = lib.types.bool;
            };
            layer = mylib.noctalia.mkLayerOption "top";
            margin.edges.outer = lib.mkOption {
              default = 5;
              type = lib.types.int;
            };
            margin.edges.inner = lib.mkOption {
              default = 0;
              type = lib.types.int;
            };
            margin.ends = lib.mkOption {
              default = 32;
              type = lib.types.int;
            };
            padding = lib.mkOption {
              default = 16;
              type = lib.types.int;
            };
            panel-overlap = lib.mkOption {
              default = 1;
              type = lib.types.int;
            };
            position = lib.mkOption {
              default = "top";
              type = lib.types.enum [ "left" "right" "top" "bottom" ];
            };
            radii = lib.mkOption {
              default = [ 12 12 12 12 ];
              type = with lib.types; listOf int;
            };
            reserve-space = lib.mkOption {
              default = true;
              type = lib.types.bool;
            };
            scale = lib.mkOption {
              default = 1.0;
              type = lib.types.float;
            };
            shadow = lib.mkEnableOption;
            show-on-workspace-switch = lib.mkOption {
              default = true;
              type = lib.types.bool;
            };
            show-tooltip = lib.mkOption {
              default = true;
              type = lib.types.bool;
            };
            smart-auto-hide = lib.mkEnableOption "";
            thickness = lib.mkOption {
              default = 32;
              type = lib.types.int;
            };
            widget-spacing = lib.mkOption {
              default = 8;
              type = lib.types.int;
            };
            dead-zone.click_through = lib.mkEnableOption "";
            capsule-groups = lib.mkOption {
              default = {
                player = {
                  enable = true;
                  accordion = false;
                  accordion-direction = "end";
                  border = mylib.noctalia.mkBorderOption {
                    color = "outline_variant";
                    width = 2.0;
                  };
                  fill = "surface_container";
                  members = [ "media" "audio-visualizer" ];
                  opacity = 1.0;
                  padding = 8;
                };
              };
            };
            start = mylib.noctalia.mkBarSectionOption [
              "launcher"   
              "clock"
              { group = "player"; }
            ];
            center = mylib.noctalia.mkBarSectionOption [
              "workspaces"
            ];
            end = mylib.noctalia.mkBarSectionOption [
              "tray"
              "notifications"
              "clipboard"
              "network"
              "bluetooth"
              "volume"
              "brightness"
              "battery"
              "control-center"
              "session"
            ];
          });
          widgets = {
            battery.warning_threshold = lib.mkOption {
              default = 10;
              type = lib.types.int;
            };
            bluetooth.connect-when-enabled = lib.mkEnableOption "";
            bluetooth.connection-notifications = lib.mkEnableOption "";
            brightness.enable-ddcutil = lib.mkEnableOption "";
            brightness.ignore-mmids = lib.mkOption {
              default = [];
              type = lib.types.listOf lib.types.str;
            };
            brightness.sync-all-monitors = lib.mkEnableOption "";
            calendar.enable = lib.mkEnableOption "";
            calendar.dedupe-events = lib.mkEnableOption "";
            calendar.dedupe-ignore-patterns = lib.mkOption {
              default = [];
              type = lib.types.listOf lib.types.str;
            };
            calendar.reminders = {
              enable = lib.mkEnableOption "";
              all-day-digest-time = lib.mkOption {
                default = "9:00";
                type = lib.types.str;
              };
              default-lead-minutes = lib.mkOption {
                default = 10;
                type = lib.types.int;
              };
              use-event-reminders = lib.mkOption {
                default = true;
                type = lib.types.bool;
              };
            };
            control-center.avatar = {
              border = lib.mkOption {
                default = true;
                type = lib.types.bool;
              };
              circular = lib.mkOption {
                default = true;
                type = lib.types.boo;
              };
            };
            control-center = {
              hidden-tabs = lib.mkOption {
                default = [];
                type = lib.types.listOf lib.types.anything;
              };
              session-button = lib.mkOption {
                default = true;
                type = lib.types.bool;
              };
              shortcut-labels = lib.mkOption {
                default = true;
                type = lib.types.boo;
              };
              sidebar = {
                main = lib.mkOption {
                  default = "compact";
                  type = lib.types.enum [ "compact" ];
                };
                section = lib.mkOption {
                  default = "compact";
                  type = lib.types.enum [ "compact" ];
                };
              };
              width = lib.mkOption {
                default = 700;
                type = lib.types.int;
              };
              calendar = mylib.noctalia.mkCalendarOption {};
              media.show-visualizer = lib.mkOption {
                default = true;
                type = lib.types.bool;
              };
              shortcuts = let
                inherit (lib.types) submodule attrsOf;
              in lib.mkOption {
                default = {
                  wifi.enable = true;
                  bluetooth.enable = true;
                  caffeine.enable = true;
                  nightlight.enable = true;
                  notification.enable = true;
                  power-profile.enable = true;
                };
                type = attrsOf (submodule {
                  enable = lib.mkEnableOption "";
                });
              };
            };
          };
          default = {
            default = {};
          };
        };
      };
    };
  };
}
