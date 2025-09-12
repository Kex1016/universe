{ config, pkgs, catppuccin, ... }:

{
  home.packages = with pkgs; [
    (catppuccin-kvantum.override {
      accent = "flamingo";
      variant = "mocha";
    })
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    kdePackages.qt6ct
    papirus-folders
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "flamingo";
    gtk.icon.enable = false;
    kvantum.enable = false;
  };

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-flamingo-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "flamingo" ];
        size = "standard";
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "flamingo";
      };
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
    };
    gtk3 = { extraConfig.gtk-application-prefer-dark-theme = true; };
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 16;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "catppuccin-mocha-flamingo-standard";
      color-scheme = "prefer-dark";
    };

    # For Gnome shell
    "org/gnome/shell/extensions/user-theme" = {
      name = "catppuccin-mocha-flamingo-standard";
    };
  };

  qt = {
    enable = true;
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source =
    (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
      General.theme = "catppuccin-mocha-flamingo";
    };
}
