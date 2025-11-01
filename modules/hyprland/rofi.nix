{
  config,
  ...
}:

{
  programs.rofi = {
    enable = true;
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        configuration = {
          show-icons = true;
          display-ssh = "󰣀 ssh:";
          display-run = "󱓞 run:";
          display-drun = "󰣖 drun:";
          display-window = "󱂬 window:";
          display-combi = "󰕘 combi:";
          display-filebrowser = "󰉋 filebrowser:";
        };

        "*" = {
          base = mkLiteral "#1e1e2e";
          surface0 = mkLiteral "#313244";
          overlay0 = mkLiteral "#6c7086";
          text = mkLiteral "#cdd6f4";

          mauve = mkLiteral "#cba6f7";
          red = mkLiteral "#f38ba8";
          peach = mkLiteral "#fab387";
          green = mkLiteral "#a6e3a1";
          lavender = mkLiteral "#b4befe";

          background-color = mkLiteral "@base";
        };

        "window" = {
          height = 600;
          width = 600;
          border = 3;
          border-radius = 10;
          border-color = mkLiteral "@lavender";
        };

        "mainbox" = {
          spacing = 0;
          children = map mkLiteral [
            "inputbar"
            "message"
            "listview"
          ];
        };

        "inputbar" = {
          color = mkLiteral "@text";
          padding = 14;
          background-color = mkLiteral "@base";
        };

        "message" = {
          padding = 10;
          background-color = mkLiteral "@overlay0";
        };

        "listview" = {
          padding = 8;
          border-radius = mkLiteral "0 0 10 10";
          border = mkLiteral "2 2 2 2";
          border-color = mkLiteral "@base";
          background-color = mkLiteral "@base";
          dynamic = false;
        };

        "textbox" = {
          text-color = mkLiteral "@text";
          background-color = mkLiteral "inherit";
        };

        "error-message" = {
          border = mkLiteral "20 20 20 20";
        };

        "entry" = {
          text-color = mkLiteral "inherit";
        };

        "prompt" = {
          text-color = mkLiteral "inherit";
          margin = mkLiteral "0 10 0 0";
        };

        "element" = {
          padding = 5;
          vertical-align = mkLiteral "0.5";
          border-radius = 10;
          background-color = mkLiteral "@surface0";
        };

        "element.selected.normal" = {
          background-color = mkLiteral "@overlay0";
        };

        "element.alternate.normal" = {
          background-color = mkLiteral "inherit";
        };

        "element.normal.active" = {
          background-color = mkLiteral "@peach";
        };

        "element.alternate.active" = {
          background-color = mkLiteral "@peach";
        };

        "element.selected.active" = {
          background-color = mkLiteral "@green";
        };

        "element.normal.urgent" = {
          background-color = mkLiteral "@red";
        };

        "element.alternate.urgent" = {
          background-color = mkLiteral "@red";
        };

        "element.selected.urgent" = {
          background-color = mkLiteral "@mauve";
        };

        "element-text" = {
          size = 40;
          margin = mkLiteral "0 10 0 0";
          vertical-align = mkLiteral "0.5";
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "@text";
        };

        "element-icon" = {
          size = 40;
          margin = mkLiteral "0 10 0 0";
          vertical-align = mkLiteral "0.5";
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "@text";
        };

        "element-text.active" = {
          text-color = mkLiteral "@base";
        };

        "element-text.urgent" = {
          text-color = mkLiteral "@base";
        };
      };
  };
}
