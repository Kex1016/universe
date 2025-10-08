{ pkgs-unstable, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscodium;
    profiles.majo = {
      extensions = with pkgs-unstable.vscode-extensions; [
        mkhl.direnv
        jnoortheen.nix-ide
        leonardssh.vscord
        editorconfig.editorconfig
        arrterian.nix-env-selector
        mkhl.shfmt
        bradlc.vscode-tailwindcss
        ban.spellright
        christian-kohler.npm-intellisense
        christian-kohler.path-intellisense
        dbaeumer.vscode-eslint
        eg2.vscode-npm-script
        esbenp.prettier-vscode
        humao.rest-client
        biomejs.biome
        gruntfuggly.todo-tree
      ];
      userSettings = {
        "editor.fontFamily" = "'RobotoMono Nerd Font Mono', 'Droid Sans Mono', 'monospace', monospace";
        "editor.fontLigatures" = true;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
          };
        };
        "[javascript][typescript][json]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
      };
    };
  };
}
