{
  config,
  hyprland,
  hyprland-dynamic-cursors,
  pkgs,
  ...
}:
{
  imports = [ ./noctalia.nix ];

  home.packages = with pkgs; [
    libnotify
    hyprpicker
    hypridle
    emojipick
    networkmanagerapplet
    # hyprcap dependencies
    wf-recorder
    grim
    slurp
    swappy
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

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      exec-once = [
        "exec systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XCURSOR_SIZE XCURSOR_THEME"
        "exec dbus-update-activation-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XCURSOR_SIZE XCURSOR_THEME"
        "noctalia-shell >/dev/null 2>&1 &"
        "nm-applet >/dev/null 2>&1 &"
        "bash ${config.home.homeDirectory}/.local/bin/cakeland_services >/dev/null 2>&1 &"
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
        rounding = 10;
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
            enabled = false;
          };
        };
      };

      "$mainMod" = "Super";
      "$secMod" = "Super+Shift";
      "$terMod" = "Super+Alt";

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, X, exec, noctalia-shell ipc call sessionMenu toggle"
        "$mainMod, F, exec, $fileManager"
        "$mainMod, Space, togglefloating,"
        "$mainMod, D, exec, noctalia-shell ipc call launcher toggle"
        "$mainMod, B, exec, $browser"
        "$mainMod, E, exec, $editor"
        "$terMod, S, exec, ~/.local/bin/hyprcap shot region -zcw"
        "$mainMod, L, exec, noctalia-shell ipc call lockScreen lock"
        "$secMod, F, fullscreen"

        # Toggle bar components
        "$mainMod, comma, exec, noctalia-shell ipc call settings toggle"
        "$mainMod, V, exec, noctalia-shell ipc call launcher clipboard"
        "$mainMod, N, exec, noctalia-shell ipc call notifications toggleHistory"
        "$mainMod, N, exec, hyprpanel t notificationsmenu"
        "$mainMod, N, exec, hyprpanel t notificationsmenu"
        "$mainMod, N, exec, hyprpanel t notificationsmenu"
        "$mainMod, N, exec, hyprpanel t notificationsmenu"
        "$mainMod, C, exec, noctalia-shell ipc call calendar toggle"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$terMod, left, layoutmsg, mfact -0.02"
        "$terMod, right, layoutmsg, mfact +0.02"

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

        # Music
        "$secMod, M, togglespecialworkspace, music"

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
        ",XF86AudioRaiseVolume, exec, noctalia-shell ipc call volume increase"
        ",XF86AudioLowerVolume, exec, noctalia-shell ipc call volume decrease"
        ",XF86AudioMute, exec, noctalia-shell ipc call volume muteOutput"
        ",XF86AudioMicMute, exec, noctalia-shell ipc call volume muteInput"
        ",XF86MonBrightnessUp, exec, noctalia-shell ipc call brightness increase"
        ",XF86MonBrightnessDown, exec, noctalia-shell ipc call brightness decrease"
      ];

      # Requires playerctl
      bindl = [
        ", XF86AudioNext, exec, noctalia-shell ipc call media next"
        ", XF86AudioPause, exec, noctalia-shell ipc call media playPause"
        ", XF86AudioPlay, exec, noctalia-shell ipc call media playPause"
        ", XF86AudioPrev, exec, noctalia-shell ipc call media previous"
      ];

      windowrule = [
        "suppress_event maximize,              match:class .*"
        "no_focus on,                          match:class ^$,match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0"
        "move (monitor_w*0.5) (monitor_h*0.5), match:class Codium"
        "workspace special:music,              match:class Spotify"
        "workspace special:music,              match:class Spotify, match:workspace .*"
        "float on,                             match:class ^(one.alynx.showmethekey)$"
        "pin on,                               match:class ^(showmethekey-gtk)$"
        "float on,                             match:class ^(showmethekey-gtk)$"
        "move 100%-260 -45,                    match:class ^(showmethekey-gtk)$"
        "pin on,                               match:class ^(Proton Pass)$"
        "float on,                             match:class ^(Proton Pass)$"
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "noctalia-shell ipc call lockScreen lock";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        # Lock the screen
        {
          timeout = 300;
          on-timeout = "noctalia-shell ipc call lockScreen lock";
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
          on-timeout = "noctalia-shell ipc call sessionMenu lockAndSuspend";
        }
      ];
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

  services.hyprpolkitagent = {
    enable = true;
    package = pkgs.hyprpolkitagent;
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
