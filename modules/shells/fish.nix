{ config, pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.fish = {
    enable = true;
    functions = { fish_greeting = "fastfetch"; };
    shellAliases = {
      ritual = "sudo nixos-rebuild switch --flake $HOME/NixOS#coven";
      cp = "/run/current-system/sw/bin/cp --reflink=auto -v";
      rm = "trash --trash-dir ${config.home.homeDirectory}/Trash";
      btw = "echo i use nix btw :3";
    };
  };
}
