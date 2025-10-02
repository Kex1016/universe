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
      convene = "cd $HOME/NixOS && nix flake update";
      sacrifice = "sudo nixos-rebuild switch --flake $HOME/NixOS#coven";
      ritual = "convene && sacrifice";
      cp = "/run/current-system/sw/bin/cp --reflink=auto -v";
      rm = "trash --trash-dir ${config.home.homeDirectory}/Trash";
      btw = "fastfetch";
    };
  };
}
