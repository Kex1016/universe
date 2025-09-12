{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ dust duf nixfmt direnv hyprls pipes wget git ];

  programs = {
    git = {
      enable = true;
      userName = "cakes";
      userEmail = "cakes@haiiro.moe";
    };
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
    };
    eza = {
      enable = true;
      enableFishIntegration = true;
      colors = "auto";
      icons = "auto";
      git = true;
      extraOptions = [ "--group-directories-first" "--header" ];
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
          padding = { right = 1; };
        };
        display = {
          size = { binaryPrefix = "si"; };
          color = "blue";
          separator = "  ";
        };
        modules = [
          {
            type = "datetime";
            key = "Date";
            format = "{1}-{3}-{11}";
          }
          {
            type = "datetime";
            key = "Time";
            format = "{14}:{17}:{20}";
          }
          "break"
          "player"
          "media"
        ];
      };
    };
  };
}
