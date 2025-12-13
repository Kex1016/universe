{ ... }:
{
  # > Hyprland
  wayland.windowManager.hyprland.settings = {
    monitor = [ "eDP-1, 1920x1080@60, 0x0, 1" ];

    input = {
      kb_layout = "hu";
    };
  };

  # > Hyprlock
  programs.hyprlock.settings = {
    label = [
      {
        text = ''<span weight="heavy">$TIME</span>'';
        halign = "center";
        valign = "center";
        position = "0, 100";
        font_family = "Roboto Flex";
        font_size = 100;
      }
      {
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
      sacrifice = "cd $HOME/.nixos/universe && git pull && sudo nixos-rebuild switch --flake $HOME/.nixos/universe#balefire";
    };
  };
}
