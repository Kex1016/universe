{ pkgs, ... }:
{
  stylix = {
    enable = true;

    base16Scheme = builtins.toPath ./themes/everforest-dark-hard.yml;
    image = ../../../../extra/pics/coven/w_elaina2.jpg;
    polarity = "dark";

    cursor = {
      name = "DMZ-White";
      size = 24;
      package = pkgs.vanilla-dmz;
    };
    fonts = {
      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto";
      };
      serif = {
        package = pkgs.roboto-serif;
        name = "Roboto Serif";
      };
      monospace = {
        package = pkgs.nerd-fonts.roboto-mono;
        name = "RobotoMono Nerd Font Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
