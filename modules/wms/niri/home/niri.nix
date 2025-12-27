{ config, pkgs, ... }:
{
  imports = [ ./noctalia.nix ];

  home.packages = with pkgs; [
    libnotify
    networkmanagerapplet
    # hyprcap dependencies
    wf-recorder
    grim
    slurp
    swappy
  ];

  xdg = {
    portal = {
      enable = true;
      config.niri = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Access" = "gtk";
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };
  };

  programs.niri = {
    package = pkgs.niri-unstable;
    settings = {
      environment = {
        NIXOS_OZONE_WL = "1"; # support electron and chromium based apps
        DISPLAY = ":0"; # important for xwayland-satellite
        QT_QPA_PLATFORM = "wayland"; # force QT apps to always use wayland
      };

      screenshot-path = "~/Pictures/Screenshots/%Y-%m/%d_%H%M%S";

      spawn-at-startup = [
        { command = [ "xwayland-satellite" ]; }
        { command = [ "noctalia-shell" ]; }
      ];

      outputs = {
        "DP-1" = {
          enable = true;
          mode = {
            width = 2560;
            height = 1080;
            refresh = 200.007;
          };
          position.x = 3000;
          position.y = 180;
          focus-at-startup = true;
        };
        "DP-2" = {
          enable = true;
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.0;
          };
          position.x = 1920;
          position.y = 0;
          transform.rotation = 90;
        };
      };

      layout.center-focused-column = "always";

      input = {
        mouse = {
          accel-profile = "flat";
        };

        workspace-auto-back-and-forth = true;
      };

      binds = with config.lib.niri.actions; {
        ## XF86
        "XF86AudioRaiseVolume" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "volume"
            "increase"
          ];
        };
        "XF86AudioLowerVolume" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "volume"
            "decrease"
          ];
        };
        "XF86AudioMute" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "volume"
            "muteOutput"
          ];
        };
        "XF86AudioMicMute" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "volume"
            "muteInput"
          ];
        };
        "XF86MonBrightnessUp" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "brightness"
            "increase"
          ];
        };
        "XF86MonBrightnessDown" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "brightness"
            "decrease"
          ];
        };
        "XF86AudioNext" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "media"
            "next"
          ];
        };
        "XF86AudioPause" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "media"
            "playPause"
          ];
        };
        "XF86AudioPlay" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "media"
            "playPause"
          ];
        };
        "XF86AudioPrev" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "media"
            "previous"
          ];
        };

        ## APPS
        "Mod+Return" = {
          action.spawn = "kitty";
        };
        "Mod+Q" = {
          action = close-window;
        };
        "Mod+X" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "sessionMenu"
            "toggle"
          ];
        };
        "Mod+F" = {
          action.spawn = "nautilus";
        };
        "Mod+D" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "launcher"
            "toggle"
          ];
        };
        "Mod+B" = {
          action.spawn = "vivaldi";
        };
        "Mod+E" = {
          action.spawn = "codium";
        };
        "Mod+L" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "lockScreen"
            "lock"
          ];
        };

        ## BAR
        "Mod+comma" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "settings"
            "toggle"
          ];
        };
        "Mod+V" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "launcher"
            "clipboard"
          ];
        };
        "Mod+N" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "notifications"
            "toggleHistory"
          ];
        };
        "Mod+C" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "calendar"
            "toggle"
          ];
        };
        "Mod+S" = {
          action.spawn = [
            "~/.local/bin/hyprcap"
            "shot"
            "region"
            "-zcw"
          ];
        };

        "Mod+WheelScrollDown" = {
          action = focus-column-right;
        };
        "Mod+WheelScrollUp" = {
          action = focus-column-left;
        };
        "Mod+Shift+WheelScrollDown" = {
          action = focus-workspace-down;
        };
        "Mod+Shift+WheelScrollUp" = {
          action = focus-workspace-up;
        };

        "Mod+Down" = {
          action = focus-workspace-down;
        };
        "Mod+Up" = {
          action = focus-workspace-up;
        };
        "Mod+Left" = {
          action = focus-column-left;
        };
        "Mod+Right" = {
          action = focus-column-right;
        };

        "Mod+Shift+Down" = {
          action = move-workspace-down;
        };
        "Mod+Shift+Up" = {
          action = move-workspace-up;
        };
        "Mod+Shift+Left" = {
          action = move-column-left-or-to-monitor-left;
        };
        "Mod+Shift+Right" = {
          action = move-column-right-or-to-monitor-right;
        };

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
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

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
