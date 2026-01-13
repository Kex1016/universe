{ pkgs, hytale-launcher, ... }:
{
  home.packages = with pkgs; [
    prismlauncher
    r2modman
    lutris
    osu-lazer-bin
    xivlauncher
    protonplus
    etterna
    (pkgs.nexusmods-app.override { _7zz = pkgs._7zz-rar; })
    ocelot-desktop
    hytale-launcher.packages.${pkgs.system}.default
  ];
}
