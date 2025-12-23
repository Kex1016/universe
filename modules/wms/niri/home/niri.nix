{
  config,
  pkgs,
  ...
}:
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

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.niri = {
    package = pkgs.niri-unstable;
    settings = {
      environment = {
        NIXOS_OZONE_WL = "1"; # support electron and chromium based apps
        DISPLAY = ":0"; # important for xwayland-satellite
        # QT_QPA_PLATFORM = "wayland"; # optional: force QT apps to always use wayland
      };

      screenshot-path = "~/Pictures/Screenshots/%Y-%m/%d_%H%M%S";

      spawn-at-startup = [
        { command = [ "xwayland-satellite" ]; }
        { command = [ "noctalia-shell" ]; }
      ];

      input = {
        keyboard.xkb = {
          layout = "us";
        };

        mouse = {
          accel-profile = "flat";
        };

        warp-mouse-to-focus.enable = true;
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

        # TODO: HOW THE FUCK DO I SCREENSHOT

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

        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action = focus-workspace-down;
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action = focus-workspace-up;
        };
        "Mod+WheelScrollLeft" = {
          action = focus-column-left;
        };
        "Mod+WheelScrollRight" = {
          action = focus-column-right;
        };
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
