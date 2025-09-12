{ config, pkgs, ... }:

{
  imports = [
    ./modules/userDirs.nix
    ./modules/symlinks.nix
    ./modules/shells/fish.nix

    # WM
    ./modules/catppuccin.nix
    ./modules/hyprland/wm.nix
    ./modules/hyprland/waybar.nix
    ./modules/hyprland/rofi.nix
    ./modules/hyprland/kitty.nix

    # APPS
    ./modules/apps/cli.nix
    ./modules/apps/essentials.nix
    ./modules/apps/nemo.nix
    ./modules/apps/vscode.nix
    ./modules/apps/neovim.nix
    ./modules/apps/equibop.nix
  ];

  home.username = "majo";
  home.homeDirectory = "/home/majo";
  home.stateVersion = "25.05";
  home.sessionPath = [ "$HOME/.local/bin" ];
  home.packages = with pkgs; [ ];
  programs.bash = {
    enable = true;
    shellAliases = { btw = "echo i use nixos, btw"; };
  };
}
