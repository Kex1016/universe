{
  config,
  lib,
  ...
}:
{
  imports = [
    ../../apps/gaming.nix
  ];

  # > Hyprland
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-1, 2560x1080@200, 1080x180, 1"
      "DP-2, 1920x1080@60, 0x0, 1, transform, 1"
    ];

    workspace = [
      "1, monitor:DP-1"
      "2, monitor:DP-1"
      "3, monitor:DP-1"
      "4, monitor:DP-1"
      "5, monitor:DP-1"
      "6, monitor:DP-1"
      "7, monitor:DP-1"
      "8, monitor:DP-1"
      "9, monitor:DP-1"
      "0, monitor:DP-2"
    ];
  };

  # > Hyprpaper
  services.hyprpaper.settings = {
    preload = [
      "${config.home.homeDirectory}/.cakepics/${hostname}/wallhaven-gp9dlq.png"
      "${config.home.homeDirectory}/.cakepics/${hostname}/wallhaven-yxkmjx.png"
    ];
    wallpaper = [
      "DP-1, ${config.home.homeDirectory}/.cakepics/${hostname}/wallhaven-gp9dlq.png"
      "DP-2, ${config.home.homeDirectory}/.cakepics/${hostname}/wallhaven-yxkmjx.png"
    ];
  };
  # > Hyprlock
  services.hyprlock.settings = {
    label = [
      {
        monitor = "DP-2";
        text = ''<span weight="heavy">$TIME</span>'';
        halign = "center";
        valign = "center";
        position = "0, 50";
        font_family = "Roboto Flex";
        font_size = 100;
      }
      {
        monitor = "DP-2";
        text = ''<span weight="normal">Grimoire sealed. Chant the spell to unlock.</span>'';
        halign = "center";
        valign = "center";
        position = "0, -50";
        font_family = "Roboto Flex";
        font_size = 15;
      }
      {
        monitor = "DP-1";
        text = ''<span weight="heavy">$TIME</span>'';
        halign = "center";
        valign = "center";
        position = "0, 100";
        font_family = "Roboto Flex";
        font_size = 100;
      }
      {
        monitor = "DP-1";
        text = ''<span weight="normal">Grimoire sealed. Chant the spell to unlock.</span>'';
        halign = "center";
        valign = "center";
        position = "0, 0";
        font_family = "Roboto Flex";
        font_size = 15;
      }
    ];

    input-field = [
      {
        monitor = "DP-1";
        size = "250, 50";
        position = "0, -80";
        dots_center = true;
        fade_on_empty = false;
        font_color = "$text";
        inner_color = "$base";
        outer_color = "$mantle";
        outline_thickness = 5;
        placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
        rounding = 0;
      }
    ];
  };
}
