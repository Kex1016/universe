{
  config,
  pkgs,
  pkgs-unstable,
  catppuccin,
  ...
}:

let
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  catppuccin-kv = (pkgs.catppuccin-kvantum.override {
      accent = "flamingo";
      variant = "mocha";
    });
in {
  home.packages = [
    catppuccin-kv
    pkgs-unstable.libsForQt5.qtstyleplugin-kvantum
    pkgs-unstable.qt6Packages.qtstyleplugin-kvantum
    pkgs.libsForQt5.qt5ct
    pkgs.kdePackages.qt6ct
    pkgs.papirus-folders
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "flamingo";
    gtk.icon.enable = false;
    kvantum.enable = false;
    hyprlock.useDefaultConfig = false;
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
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "catppuccin-mocha-dark-cursors";
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
    # style.name = "kvantum";
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source =
    (pkgs.formats.ini { }).generate "kvantum.kvconfig"
      {
        General.theme = "catppuccin-mocha-flamingo";
      };
  
  xdg.configFile."Kvantum/catppuccin-mocha-flamingo" = {
    source = create_symlink "${catppuccin-kv}/share/Kvantum/catppuccin-mocha-flamingo";
    recursive = true;
  };
}
