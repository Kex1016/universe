{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  binds =
    {
      suffixes,
      prefixes,
      substitutions ? { },
    }:
    let
      replacer = replaceStrings (attrNames substitutions) (attrValues substitutions);
      format =
        prefix: suffix:
        let
          actual-suffix =
            if isList suffix.action then
              {
                action = head suffix.action;
                args = tail suffix.action;
              }
            else
              {
                inherit (suffix) action;
                args = [ ];
              };

          action = replacer "${prefix.action}-${actual-suffix.action}";
        in
        {
          name = "${prefix.key}+${suffix.key}";
          value.action.${action} = actual-suffix.args;
        };
      pairs =
        attrs: fn:
        concatMap (
          key:
          fn {
            inherit key;
            action = attrs.${key};
          }
        ) (attrNames attrs);
    in
    listToAttrs (pairs prefixes (prefix: pairs suffixes (suffix: [ (format prefix suffix) ])));
in
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
        { sh = "QT_STYLE_OVERRIDE=Fusion QT_QPA_PLATFORM=xcb synology-drive autostart"; }
      ];

      window-rules = [
        {
          matches = [ ];
          geometry-corner-radius = {
            bottom-left = 15.0;
            bottom-right = 15.0;
            top-left = 15.0;
            top-right = 15.0;
          };
          clip-to-geometry = true;
        }
        {
          matches = [
            {
              title = "Picture-in-Picture";
              app-id = "zen-beta";
            }
          ];
          open-floating = true;
        }
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

      input = {
        mouse = {
          accel-profile = "flat";
        };

        workspace-auto-back-and-forth = true;
      };

      binds =
        with config.lib.niri.actions;
        let
          sh = spawn "sh" "-c";
        in
        lib.attrsets.mergeAttrsList [
          ## XF86
          {
            "XF86AudioRaiseVolume".action = sh "noctalia-shell ipc call volume increase";
            "XF86AudioLowerVolume".action = sh "noctalia-shell ipc call volume decrease";
            "XF86AudioMute".action = sh "noctalia-shell ipc call volume muteOutput";
            "XF86AudioMicMute".action = sh "noctalia-shell ipc call volume muteInput";
            "XF86MonBrightnessUp".action = sh "noctalia-shell ipc call brightness increase";
            "XF86MonBrightnessDown".action = sh "noctalia-shell ipc call brightness decrease";
            "XF86AudioNext".action = sh "noctalia-shell ipc call media next";
            "XF86AudioPause".action = sh "noctalia-shell ipc call media playPause";
            "XF86AudioPlay".action = sh "noctalia-shell ipc call media playPause";
            "XF86AudioPrev".action = sh "noctalia-shell ipc call media previous";
          }
          # Other
          {
            "Mod+colon".action = show-hotkey-overlay;
            "Mod+Q".action = close-window;
          }
          # Window binds
          (binds {
            suffixes = {
              "Left" = "column-left";
              "Down" = "window-down";
              "Up" = "window-up";
              "Right" = "column-right";
              "J" = "column-left";
              "K" = "window-down";
              "L" = "window-up";
              "M" = "column-right";
            };

            prefixes = {
              "Mod" = "focus";
              "Mod+Ctrl" = "move";
              "Mod+Shift" = "focus-monitor";
              "Mod+Shift+Ctrl" = "move-window-to-monitor";
            };
            substitutions = {
              "monitor-column" = "monitor";
              "monitor-window" = "monitor";
            };
          })
          {
            "Mod+G".action = switch-focus-between-floating-and-tiling;
            "Mod+Shift+G".action = toggle-window-floating;
          }
          (binds {
            suffixes = {
              "Home" = "first";
              "End" = "last";
            };
            prefixes = {
              "Mod" = "focus-column";
              "Mod+Ctrl" = "move-column-to";
            };
          })
          (binds {
            suffixes = {
              "U" = "workspace-down";
              "Page_Down" = "workspace-down";
              "Down" = "workspace-down";
              "WheelScrollDown" = "workspace-down";
              "I" = "workspace-up";
              "WheelScrollUp" = "workspace-up";
              "Page_Up" = "workspace-up";
              "Up" = "workspace-up";
            };
            prefixes = {
              "Mod" = "focus";
              "Mod+Ctrl" = "move-window-to";
              "Mod+Shift" = "move";
            };
          })
          (binds {
            suffixes = builtins.listToAttrs (
              map (n: {
                name = toString n;
                value = [
                  "workspace"
                  n
                ];
              }) (range 1 9)
            );
            prefixes = {
              "Mod" = "focus";
              "Mod+Shift" = "move-window-to";
            };
          })
          {
            ## APPS
            "Mod+Q".action = close-window;
            "Mod+Return".action.spawn = "kitty";
            "Mod+D".action = sh "noctalia-shell ipc call launcher toggle";
            "Mod+T".action.spawn = "nautilus";
            "Mod+B".action.spawn = "zen-beta";
            "Mod+E".action.spawn = "codium";
            "Mod+Backspace".action = sh "noctalia-shell ipc call lockScreen lock";
          }
          {
            # Move columns
            "Mod+Comma".action = consume-window-into-column;
            "Mod+semicolon".action = expel-window-from-column;
            "Mod+Space".action = toggle-column-tabbed-display;
            "Mod+C".action = center-column;

            # Resize columns
            "Mod+R".action = switch-preset-column-width;
            "Mod+Shift+R".action = switch-preset-window-height;
            "Mod+Ctrl+R".action = reset-window-height;
            "Mod+Ctrl+F".action = expand-column-to-available-width;
            "Mod+F".action = maximize-column;
            "Mod+Shift+F".action = fullscreen-window;
            "Mod+KP_5".action = set-column-width "-10%";
            "Mod+KP_6".action = set-column-width "+10%";
            "Mod+Shift+KP_5".action = set-window-height "-10%";
            "Mod+Shift+KP_6".action = set-window-height "+10%";

            # Misc
            "Mod+A".action = toggle-overview;
            "Mod+X".action = sh "noctalia-shell ipc call sessionMenu toggle"; # Session menu
            "Mod+V".action = sh "noctalia-shell ipc call launcher clipboard"; # Clipboard
            "Mod+N".action = sh "noctalia-shell ipc call notifications toggleHistory"; # Notifications
            "Mod+S".action = sh "~/.local/bin/hyprcap shot region -zcw"; # Screenshot
          }
        ];

      layout = {
        always-center-single-column = true;
        center-focused-column = "on-overflow";
        empty-workspace-above-first = true;

        preset-column-widths = [
          { proportion = 1.0 / 3.0; }
          { proportion = 1.0 / 2.0; }
          { proportion = 2.0 / 3.0; }
        ];
        default-column-width = {
          proportion = 1.0 / 2.0;
        };
        tab-indicator = {
          position = "top";
          gaps-between-tabs = 10;
          place-within-column = true;
        };
      };
      overview = {
        backdrop-color = "#000000";
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
