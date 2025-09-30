{
  wayland.windowManager.hyprland.settings = {
    # This is an example Hyprland config file.
    # Refer to the wiki for more information.
    # https://wiki.hypr.land/Configuring/

    # Please note not all available settings / options are set here.
    # For a full list, see the wiki

    # You can split this configuration into multiple files
    # Create your files separately and then link them to this file like this:
    # source = ~/.config/hypr/myColors.conf


    ################
    ### MONITORS ###
    ################

    monitor = ", preferred, auto, auto";
    "$terminal" = "ghostty";
    "$menu" = "rofi -show drun";


    #################
    ### AUTOSTART ###
    #################

    # Autostart necessary processes (like notifications daemons, status bars, etc.)
    # Or execute your favorite apps at launch like this:

    exec-once = [
      "$terminal"
      # "$browser"
    ];


    #############################
    ### ENVIRONMENT VARIABLES ###
    #############################

    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
    ];


    ###################
    ### PERMISSIONS ###
    ###################

    # See https://wiki.hypr.land/Configuring/Permissions/
    # Please note permission changes here require a Hyprland restart and are not applied on-the-fly
    # for security reasons

    ecosystem.no_update_news = true;

    # permission = /usr/(bin|local/bin)/grim, screencopy, allow
    # permission = /usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow
    # permission = /usr/(bin|local/bin)/hyprpm, plugin, allow


    #####################
    ### LOOK AND FEEL ###
    #####################

    # Refer to https://wiki.hypr.land/Configuring/Variables/

    # https://wiki.hypr.land/Configuring/Variables/#general
    general = {
        gaps_in = 5;
        gaps_out = 20;

        border_size = 2;

        # https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
        allow_tearing = true;

        layout = "dwindle";
    };

    # https://wiki.hypr.land/Configuring/Variables/#decoration
    decoration = {
        rounding = 10;
        rounding_power = 2;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
        };

        # https://wiki.hypr.land/Configuring/Variables/#blur
        blur.enabled = false;
    };

    # https://wiki.hypr.land/Configuring/Variables/#animations
    animations.enabled = false;

    # Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
    # "Smart gaps" / "No gaps when only"
    # uncomment all if you wish to use that.
    # workspace = w[tv1], gapsout:0, gapsin:0
    # workspace = f[1], gapsout:0, gapsin:0
    # windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
    # windowrule = rounding 0, floating:0, onworkspace:w[tv1]
    # windowrule = bordersize 0, floating:0, onworkspace:f[1]
    # windowrule = rounding 0, floating:0, onworkspace:f[1]

    # See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
    dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
    };

    # See https://wiki.hypr.land/Configuring/Master-Layout/ for more
    master = {
        new_status = "master";
    };

    # https://wiki.hypr.land/Configuring/Variables/#misc
    misc = {
        force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
    };


    #############
    ### INPUT ###
    #############

    # https://wiki.hypr.land/Configuring/Variables/#input
    input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 1;

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false;
        };
    };

    ###################
    ### KEYBINDINGS ###
    ###################

    # See https://wiki.hypr.land/Configuring/Keywords/
    "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

    bind = [
      # General binds
      "$mainMod, RETURN, exec, $terminal"
      "$mainMod, Q, killactive,"
      "$mainMod SHIFT, X, exit,"
      "$mainMod, SPACE, togglefloating,"
      "$mainMod, D, exec, $menu"
      "$mainMod, P, pseudo, # dwindle"
      "$mainMod, O, togglesplit, # dwindle"

      # Move focus with mainMod + hjkl
      "$mainMod, H, movefocus, l"
      "$mainMod, L, movefocus, r"
      "$mainMod, K, movefocus, u"
      "$mainMod, J, movefocus, d"

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      "$mainMod SHIFT, H, movecurrentworkspacetomonitor, l"
      "$mainMod SHIFT, L, movecurrentworkspacetomonitor, r"
      "$mainMod SHIFT, K, movecurrentworkspacetomonitor, u"
      "$mainMod SHIFT, J, movecurrentworkspacetomonitor, d"

      # Example special workspace (scratchpad)
      "$mainMod, S, togglespecialworkspace, magic"
      "$mainMod SHIFT, S, movetoworkspace, special:magic"

      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
    ];

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # Laptop multimedia keys for volume and LCD brightness
    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];

    # Requires playerctl
    bindl = [
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];

    ##############################
    ### WINDOWS AND WORKSPACES ###
    ##############################

    # See https://wiki.hypr.land/Configuring/Window-Rules/ for more
    # See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

    # Example windowrule
    # windowrule = float,class:^(kitty)$,title:^(kitty)$
    windowrule = [
      # Ignore maximize requests from apps. You'll probably like this.
      "suppressevent maximize, class:.*"
      # Fix some dragging issues with XWayland
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ];
  };
}
