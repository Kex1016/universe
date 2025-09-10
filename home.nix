{ config, pkgs, ... }:

{
  imports = [
    # DOTS
    ./modules/symlinks.nix

    # WM
    ./modules/hyprland/waybar.nix
    ./modules/hyprland/rofi.nix

    # APPS
    ./modules/apps/neovim.nix
    ./modules/apps/equibop.nix
  ];

  home.username = "majo";
  home.homeDirectory = "/home/majo";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
  home.packages = with pkgs; [ ];
  programs.bash = {
    enable = true;
    shellAliases = { btw = "echo i use nixos, btw"; };
  };
}
