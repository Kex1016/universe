{ config, pkgs, ... }:

{
  imports = [
    # USERDIRS
    ./modules/userDirs.nix

    # WM
    ./modules/hyprland/wm.nix

    # THEME
    ./modules/catppuccin.nix

    # DOTS
    ./modules/symlinks.nix

    # WM
    ./modules/hyprland/waybar.nix
    ./modules/hyprland/rofi.nix
    ./modules/hyprland/kitty.nix

    # SHELLS
    ./modules/shells/fish.nix

    # APPS
    ./modules/apps/cli.nix
    ./modules/apps/nemo.nix
    ./modules/apps/vscode.nix
    ./modules/apps/neovim.nix
    ./modules/apps/equibop.nix
  ];

  home.username = "majo";
  home.homeDirectory = "/home/majo";
  programs.git = {
    enable = true;
    userName = "cakes";
    userEmail = "cakes@haiiro.moe";
  };
  home.stateVersion = "25.05";
  home.sessionPath = [ "$HOME/.local/bin" ];
  home.packages = with pkgs; [ ];
  programs.bash = {
    enable = true;
    shellAliases = { btw = "echo i use nixos, btw"; };
  };
}
