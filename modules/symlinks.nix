{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/hyprland/dots/.config";
  binfiles = "${config.home.homeDirectory}/hyprland/dots/.local/bin";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
  	hypr = "hypr";
	rofi = "rofi";
  };
in {
  # bins
  home.file.".local/bin" = {
    source = ../dots/.local/bin;
    recursive = true;
    executable = true;
  };

  # dots
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
