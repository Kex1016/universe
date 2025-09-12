{ config, pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.fish = {
    enable = true;
    functions = { fish_greeting = ""; };
    shellAliases = {
      ritual = "sudo nixos-rebuild switch --flake $HOME/hyprland#coven";
    };
  };
}
