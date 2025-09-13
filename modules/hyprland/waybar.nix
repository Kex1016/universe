{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ waybar ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";

        modules-left = [ "hyprland/workspaces" "custom/right-arrow" ];
        modules-center =
          [ "custom/left-arrow" "clock#1" "clock#2" "custom/right-arrow" ];
        modules-right = [
          "custom/left-arrow"
          "pulseaudio"
          "memory"
          "cpu"
          "battery"
          "disk"
          "tray"
        ];

        "custom/left-arrow" = {
          format = " ";
          tooltip = false;
        };

        "custom/right-arrow" = {
          format = "";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            active = "";
          };
          persistent-workspaces = { "*" = 4; };
          disable-scroll = true;
          all-outputs = true;
          show-special = true;
        };

        "clock#1" = {
          format = "{:%a}";
          tooltip = false;
        };

        "clock#2" = {
          format = "{:%H:%M}";
          tooltip = false;
        };

        pulseaudio = {
          format = "{icon} {volume:2}%";
          format-bluetooth = "{icon}  {volume}%";
          format-muted = "MUTE";
          format-icons = {
            headphones = "";
            default = [ "" "" ];
          };
          scroll-step = 5;
          on-click = "pamixer -t";
          on-click-right = "pavucontrol";
        };

        memory = {
          interval = 5;
          format = "Mem {}%";
        };

        cpu = {
          interval = 5;
          format = "CPU {usage:2}%";
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };

        disk = {
          interval = 5;
          format = "Disk {percentage_used:2}%";
          path = "/";
        };

        tray = { icon-size = 20; };
      };
    };

    style = ''
          /*
      * Variant: Rosé Pine
      * Maintainer: DankChoir
      */

      @define-color base            #191724;
      @define-color surface         #1f1d2e;
      @define-color overlay         #26233a;

      @define-color muted           #6e6a86;
      @define-color subtle          #908caa;
      @define-color text            #e0def4;

      @define-color love            #eb6f92;
      @define-color gold            #f6c177;
      @define-color rose            #ebbcba;
      @define-color pine            #31748f;
      @define-color foam            #9ccfd8;
      @define-color iris            #c4a7e7;

      @define-color highlightLow    #21202e;
      @define-color highlightMed    #403d52;
      @define-color highlightHigh   #524f67;

      * {
          font-size: 14px;
          font-family: "DepartureMono Nerd Font";
      }

      window#waybar {
          background: @base;
          color: @text;
      }

      #custom-right-arrow,
      #custom-left-arrow {
          color: @highlightHigh;
          background: @base;
          font-size: 18px;
      }

      #workspaces,
      #clock.1,
      #clock.2,
      #clock.3,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk,
      #tray {
          background: @highlightHigh;
      }

      #workspaces button {
          padding: 0 2px;
          color: @text;
      }
      #workspaces button.focused {
          color: @highlightHigh;
      }
      #workspaces button:hover {
          box-shadow: inherit;
          text-shadow: inherit;
      }
      #workspaces button:hover {
          background: @highlightLow;
          border: 1px solid @highlightMed;
          padding: 0 3px;
      }

      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk {
          color: @rose;
      }

      #clock,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk {
          padding: 0 10px;
      }
    '';

  };
}
