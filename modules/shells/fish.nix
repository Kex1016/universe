{ config, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.fish = {
    enable = true;
    functions = {
      fish_greeting = "fastfetch";
    };
    shellAliases = {
      convene = "cd $HOME/.nixos/universe && git pull && nix flake update";
      ritual = "convene && sacrifice";
      cp = "/run/current-system/sw/bin/cp --reflink=auto -v";
      rm = "trash --trash-dir ${config.home.homeDirectory}/Trash";
      btw = "fastfetch";
      df = "duf";
      du = "dust";
      rungame = "gamescope --backend wayland -W 2560 -H 1080 -w 2560 -h 1080 --force-grab-cursor -r 200 --expose-wayland -- ";
    };
  };
}
