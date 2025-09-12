{ config, catppuccin, ... }:

{
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "flamingo";
    gtk.icon.enable = false;
    kvantum.enable = false;
    hyprland.enable = false;
  };
}
