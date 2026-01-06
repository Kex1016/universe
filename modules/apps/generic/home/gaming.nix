{ pkgs, ... }:
{
  home.packages = with pkgs; [
    prismlauncher
    r2modman
    lutris
    osu-lazer-bin
    xivlauncher
    protonplus
    etterna
    nexusmods-app
    ocelot-desktop
  ];
}
