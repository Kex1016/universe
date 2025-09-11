{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.plugins = with pkgs.hyprlandPlugins; [
    hypr-dynamic-cursors
    hyprwinwrap
    hyprfocus
    hyprexpo
  ];

  gtk = {
    theme.package = pkgs.catppuccin-gtk;
    iconTheme.package = pkgs.catppuccin-papirus-folders;
    cursorTheme.package = pkgs.catppuccin-cursors.mochaFlamingo;
  };
}
