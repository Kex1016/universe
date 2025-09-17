{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    dust
    duf
    nixfmt-rfc-style
    direnv
    hyprls
    pipes
    wget
    git
    psmisc
    nix-tree
    wl-clipboard
    brightnessctl
    playerctl
    trash-cli
    efibootmgr
    jq
    tokei
  ];

  programs = {
    git = {
      enable = true;
      userName = "cakes";
      userEmail = "cakes@haiiro.moe";
    };
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
    };
    eza = {
      enable = true;
      enableFishIntegration = true;
      colors = "auto";
      icons = "auto";
      git = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };
    ripgrep.enable = true;
    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [ "--cmd cd" ];
    };
    fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = "nixos_small";
          padding = {
            right = 1;
          };
        };
        display = {
          size = {
            ndigits = 0;
            maxPrefix = "MB";
          };
          color = "blue";
          separator = "  ";
          key.type = "icon";
        };
        modules = [
          {
            type = "title";
            color = {
              user = "green";
              at = "red";
              host = "blue";
            };
          }
          "os"
          "kernel"
          "memory"
          "packages"
          "uptime"
          {
            type = "colors";
            key = "Colors";
            block = {
              range = [
                1
                6
              ];
            };
          }
        ];
      };
    };
  };
}
