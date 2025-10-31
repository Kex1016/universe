{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs; [
    prismlauncher
    pkgs-unstable.r2modman
    pkgs-unstable.lutris
    pkgs-unstable.osu-lazer-bin
    pkgs-unstable.xivlauncher
    pkgs-unstable.protonplus
    pkgs-unstable.etterna
  ];

  # also see system/gaming.nix
}
