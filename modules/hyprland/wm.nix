{
  config,
  hyprland,
  hyprland-dynamic-cursors,
  pkgs,
  pkgs-unstable,
  hostname,
  ...
}:
let
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  home.packages = with pkgs-unstable; [
    libnotify
    hyprpaper
    hyprpicker
    hypridle
    hyprlock
    emojipick
    networkmanagerapplet
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    plugins = [
      hyprland-dynamic-cursors.packages.${pkgs.stdenv.hostPlatform.system}.hypr-dynamic-cursors
    ];

    settings = {
      "$terminal" = "kitty";
      "$fileManager" = "nemo";
      "$menu" = "rofi -show drun";
      "$browser" = "firefox";
      "$editor" = "emacs";

      monitor = [
        "DP-1, 2560x1080@200, 1080x180, 1"
        "DP-2, 1920x1080@60, 0x0, 1, transform, 1"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      exec-once = [
        "exec systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XCURSOR_SIZE XCURSOR_THEME"
        "exec dbus-update-activation-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XCURSOR_SIZE XCURSOR_THEME"
        "nm-applet >/dev/null 2>&1 &"
        "steam -silent >/dev/null 2>&1 &"
        "waybar >/dev/null 2>&1 &"
        "bash ${config.home.homeDirectory}/.local/bin/cakeland_services >/dev/null 2>&1 &"
        "bash ${config.home.homeDirectory}/.local/bin/randompaper ${hostname} >/dev/null 2>&1 &"
      ];

      workspace = [
        "1, monitor:DP-1"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:DP-1"
        "7, monitor:DP-1"
        "8, monitor:DP-1"
        "9, monitor:DP-1"
        "0, monitor:DP-2"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 2;

        "col.active_border" = "$flamingo";
        "col.inactive_border" = "$overlay0";

        resize_on_border = false;
        allow_tearing = false;
        layout = "master";
      };

      master = {
        mfact = 0.7;
        new_status = "slave";
        new_on_top = true;
      };

      decoration = {
        rounding = 0;
        rounding_power = 2;

        active_opacity = 1.0;
        inactive_opacity = 0.9;

        shadow = {
          enabled = false;
        };

        blur = {
          enabled = true;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "eoq, 0.85, 0, 0.15, 1"
          "lin, 0, 0, 0, 0"
        ];

        animation = [
          "windows, 1, 3, eoq, slide"
          "border, 1, 5, eoq"
          "fade, 1, 1, lin"
          "workspaces, 1, 3, eoq, slidefade 20%"
        ];
      };

      misc = {
        disable_hyprland_logo = true;
      };

      input = {
        kb_layout = "en";

        follow_mouse = 1;

        sensitivity = 0;
        accel_profile = "flat";

        touchpad = {
          natural_scroll = false;
        };
      };

      plugin = {
        dynamic-cursors = {
          enabled = true;
          mode = "tilt";
          threshold = 2;

          tilt = {
            limit = 5000;
            function = "negative_quadratic";
            window = 100;
          };

          stretch = {
            limit = 3000;
            function = "quadratic";
            window = 100;
          };

          shake = {
            enabled = true;
            nearest = true;
            threshold = 6.0;
          };
        };
      };

      "$mainMod" = "Super";
      "$secMod" = "Super+Shift";
      "$terMod" = "Super+Alt";

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, X, exec, rofi -show powermenu -modi powermenu:~/.local/bin/powermenu"
        "$mainMod, F, exec, $fileManager"
        "$mainMod, F, exec, $fileManager"
        "$mainMod, Space, togglefloating,"
        "$mainMod, D, exec, $menu"
        "$mainMod, B, exec, $browser"
        "$mainMod, E, exec, $editor"
        "$secMod, P, pseudo, # dwindle"
        "$secMod, J, togglesplit, # dwindle"
        "$secMod, W, exec, ~/.local/bin/randompaper ${hostname}"
        "$terMod, S, exec, ~/.local/bin/hyprcap shot region -cw"
        "$mainMod, L, exec, loginctl lock-session \${XDG_SESSION_ID-}"
        "$secMod, F, fullscreen"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Move windows on the same workspace
        "$secMod, left, movewindow, l"
        "$secMod, right, movewindow, r"
        "$secMod, up, movewindow, u"
        "$secMod, down, movewindow, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, exec, ~/.local/bin/cakeland_ws 1"
        "$mainMod, 2, exec,  ~/.local/bin/cakeland_ws 2"
        "$mainMod, 3, exec,  ~/.local/bin/cakeland_ws 3"
        "$mainMod, 4, exec,  ~/.local/bin/cakeland_ws 4"
        "$mainMod, 5, exec,  ~/.local/bin/cakeland_ws 5"
        "$mainMod, 6, exec,  ~/.local/bin/cakeland_ws 6"
        "$mainMod, 7, exec,  ~/.local/bin/cakeland_ws 7"
        "$mainMod, 8, exec,  ~/.local/bin/cakeland_ws 8"
        "$mainMod, 9, exec,  ~/.local/bin/cakeland_ws 9"
        "$mainMod, 0, exec,  ~/.local/bin/cakeland_ws 10"

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

        # Scratchpad
        "$mainMod, S, togglespecialworkspace, magic"
        "$secMod, S, movetoworkspace, special:magic"

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

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "center,class:Codium"
      ];
    };
  };

  home.file.".cakepics" = {
    source = create_symlink "${config.home.homeDirectory}/NixOS/extra/pics";
    recursive = true;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${config.home.homeDirectory}/.cakepics/${hostname}/wallhaven-gp9dlq.png"
        "${config.home.homeDirectory}/.cakepics/${hostname}/wallhaven-yxkmjx.png"
      ];
      wallpaper = [
        "DP-1, ${config.home.homeDirectory}/.cakepics/${hostname}/wallhaven-gp9dlq.png"
        "DP-2, ${config.home.homeDirectory}/.cakepics/${hostname}/wallhaven-yxkmjx.png"
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        # Lock the screen
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        # Turn off screen
        {
          timeout = 420;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        # suspend
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    package = pkgs-unstable.hyprlock;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      animations = {
        enabled = true;
        fade_in = {
          duration = 300;
          bezier = "easeOutQuint";
        };
        fade_out = {
          duration = 300;
          bezier = "easeOutQuint";
        };
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
          shadow_passes = 2;
        }
      ];
    };
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "mouse";
      };
    };
  };

  services.udiskie = {
    enable = true;
    settings = {
      program_options = {
        udisks_version = 2;
        tray = true;
      };
      icon_names.media = [ "media-optical" ];
    };
  };

  services.copyq = {
    enable = true;
  };

  services.blueman-applet = {
    enable = true;
  };
}
