{ config, pkgs-unstable, lib, ... }:

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
      ];
      userSettings = {
        "editor.fontFamily" = "'RobotoMono Nerd Font Mono', 'Droid Sans Mono', 'monospace', monospace";
        "editor.fontLigatures" = true;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = {
              "command" = ["nixfmt"];
            };
          };
        };
      };
    };
  };
}
