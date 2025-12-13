{ ... }:
{
  imports = [ ../../apps/gaming.nix ];

  # > Hyprland
  wayland.windowManager.hyprland.settings = {
    monitor = [
      # "HDMI-A-1, 1920x1080@60, 0x0, 1"
      "HDMI-A-1, 1920x1080@60,0x0,1"
      "DP-2, 1920x1080@60, 1920x0, 1, transform, 1"
      "DP-1, 2560x1080@200, 3000x180, 1"
    ];

    exec-once = [ "steam -silent >/dev/null 2>&1 &" ];

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
      "10, monitor:HDMI-A-1"
      "11, monitor:HDMI-A-1"
      "12, monitor:HDMI-A-1"
      "13, monitor:HDMI-A-1"
    ];

    bind = [
      "$terMod, 1, exec, ~/.local/bin/cakeland_ws 10"
      "$terMod, 2, exec, ~/.local/bin/cakeland_ws 11"
      "$terMod, 3, exec, ~/.local/bin/cakeland_ws 12"
      "$terMod, 4, exec, ~/.local/bin/cakeland_ws 13"
    ];

    input = {
      kb_layout = "en";
    };
  };

  # > Hyprlock
  programs.hyprlock.settings = {
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

  # > Fish
  programs.fish = {
    shellAliases = {
      sacrifice = "cd $HOME/.nixos/universe && git pull && sudo nixos-rebuild switch --flake $HOME/.nixos/universe#coven";
    };
  };
}
